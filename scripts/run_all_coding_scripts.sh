#!/usr/bin/env -S cargo eval
//! Runs every executable script in ~/Coding/Scripts/automated/ at boot.
//!
//! Called from Hyprland's autostart.lua ([workspace 1]).
//! Each script gets a 5-minute timeout — if one hangs, it's killed so
//! the rest still run.  Script stdout/stderr go to /dev/null (they're
//! background daemons, output is not wanted), and a summary is printed
//! at the end.
//!
//! Safety over the original bash version:
//!   - per-script timeout via poll + kill (bash had none)
//!   - no output pipe to block on, so orphaned daemons can't strand the runner
//!   - exit codes and timing logged for every script

use std::fs;
use std::os::unix::fs::PermissionsExt;
use std::path::Path;
use std::process::{Command, Stdio};
use std::thread;
use std::time::{Duration, Instant};

fn main() {
    let script_dir = Path::new("/home/darius/Coding/Scripts/automated");

    if !script_dir.exists() {
        eprintln!("Directory {} not found!", script_dir.display());
        std::process::exit(1);
    }

    let timeout = Duration::from_secs(300);
    let mut results: Vec<(String, bool, String)> = Vec::new();

    let entries = match fs::read_dir(script_dir) {
        Ok(e) => e,
        Err(e) => {
            eprintln!("Failed to read {}: {e}", script_dir.display());
            std::process::exit(1);
        }
    };

    for entry in entries.flatten() {
        let path = entry.path();
        if !path.is_file() {
            continue;
        }

        let is_exec = fs::metadata(&path)
            .map(|m| m.permissions().mode() & 0o111 != 0)
            .unwrap_or(false);
        if !is_exec {
            continue;
        }

        let name = path
            .file_name()
            .unwrap()
            .to_string_lossy()
            .to_string();

        print!("[{name}] ");
        let _ = std::io::Write::flush(&mut std::io::stdout());

        let start = Instant::now();
        let mut child = match Command::new(&path)
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .spawn()
        {
            Ok(c) => c,
            Err(e) => {
                println!("FAIL (spawn error: {e})");
                results.push((name, false, format!("spawn error: {e}")));
                continue;
            }
        };

        let status = loop {
            match child.try_wait() {
                Ok(Some(s)) => break s,
                Ok(None) => {
                    if start.elapsed() >= timeout {
                        let _ = child.kill();
                        break child.wait().unwrap_or_default();
                    }
                    thread::sleep(Duration::from_millis(100));
                }
                Err(e) => {
                    println!("WAIT ERROR: {e}");
                    results.push((name.clone(), false, format!("wait error: {e}")));
                    break child.wait().unwrap_or_default();
                }
            }
        };

        let elapsed = start.elapsed().as_secs();
        if status.success() {
            println!("OK ({elapsed}s)");
            results.push((name, true, format!("{elapsed}s")));
        } else if elapsed >= timeout.as_secs() {
            println!("TIMEOUT (killed after {elapsed}s)");
            results.push((name, false, "TIMEOUT".to_string()));
        } else {
            let code = status.code().map_or("?".to_string(), |c| c.to_string());
            println!("FAIL ({elapsed}s, exit={code})");
            results.push((name, false, format!("{elapsed}s, exit={code}")));
        }
    }

    println!();
    let ok_count = results.iter().filter(|r| r.1).count();
    let fail_count = results.iter().filter(|r| !r.1).count();
    println!(
        "Automated scripts: {ok_count} OK, {fail_count} FAIL \
         ({} total)",
        results.len()
    );
    for (name, ok, detail) in &results {
        let mark = if *ok { " OK " } else { "FAIL" };
        println!("  [{mark}] {name} ({detail})");
    }
}
