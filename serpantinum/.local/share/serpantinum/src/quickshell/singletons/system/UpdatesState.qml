pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "../../"

Item {
    id: root

    property int updateCount: 0
    property var packagesList: []
    property bool isChecking: false
    property bool hasChecked: false

    function checkNow() {
        if (checkProc.running) return;
        isChecking = true;
        checkProc.running = true;
    }

    function launchUpdater() {
        let term = "kitty -e";
        if (typeof Config !== "undefined" && Config.rawSettings && Config.rawSettings.launcher && Config.rawSettings.launcher.terminalCommand) {
            let tc = Config.rawSettings.launcher.terminalCommand.trim();
            if (tc) term = tc;
        }
        let fullCmd = term + " yay -Syu --noconfirm --ignore gemini-cli";
        Quickshell.execDetached(["bash", "-c", fullCmd]);
    }

    Process {
        id: checkProc
        running: false
        command: [
            "bash",
            (typeof Caching !== "undefined" && Caching.serpantinumDir ? (Caching.serpantinumDir + "/scripts/check_updates.sh") : "/home/darius/.local/share/serpantinum/src/scripts/check_updates.sh"),
            "--json"
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                let out = this.text ? this.text.trim() : "";
                try {
                    let parsed = JSON.parse(out);
                    if (parsed && typeof parsed === "object") {
                        if (parsed.count !== undefined) root.updateCount = Number(parsed.count);
                        if (Array.isArray(parsed.packages)) root.packagesList = parsed.packages;
                    }
                } catch (e) {
                    let n = parseInt(out, 10);
                    if (!isNaN(n)) root.updateCount = n;
                }
                root.hasChecked = true;
                root.isChecking = false;
            }
        }
        onExited: {
            root.isChecking = false;
        }
    }

    Timer {
        id: initDelayTimer
        interval: 1000
        repeat: false
        running: true
        onTriggered: root.checkNow()
    }

    Timer {
        id: periodicTimer
        interval: 30 * 60 * 1000
        repeat: true
        running: true
        onTriggered: root.checkNow()
    }
}
