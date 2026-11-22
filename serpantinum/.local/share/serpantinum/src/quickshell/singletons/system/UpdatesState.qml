pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import "../../"

Item {
    id: root

    property int updateCount: 0
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
            term = Config.rawSettings.launcher.terminalCommand.trim();
        }
        let updateCmd = "if command -v yay >/dev/null 2>&1; then yay; else sudo pacman -Syu; fi; echo; read -p 'Press Enter to close...'";
        let fullCmd = term + " bash -c \"" + updateCmd + "\"";
        Quickshell.execDetached(["bash", "-c", fullCmd]);
    }

    Process {
        id: checkProc
        running: false
        command: [
            "bash",
            (typeof Caching !== "undefined" && Caching.serpantinumDir ? (Caching.serpantinumDir + "/scripts/check_updates.sh") : "/home/darius/dotfiles/serpantinum/.local/share/serpantinum/src/scripts/check_updates.sh")
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                let out = this.text ? this.text.trim() : "";
                let n = parseInt(out, 10);
                if (!isNaN(n)) {
                    root.updateCount = n;
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
