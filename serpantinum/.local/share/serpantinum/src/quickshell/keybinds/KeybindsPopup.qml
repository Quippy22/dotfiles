import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Window
import Quickshell
import Quickshell.Io
import "../"
import "../reusables"

Item {
    id: window
    visible: false
    focus: true

    function s(val) {
        return (typeof Scaler !== "undefined" && typeof Scaler.s === "function") ? Scaler.s(val) : val;
    }

    property var exitCallback: null

    function closePopup() {
        if (typeof masterWindow !== "undefined" && masterWindow.switchWidget) {
            masterWindow.switchWidget("hidden", "");
        } else if (typeof Caching !== "undefined" && Caching.serpantinumDir) {
            Quickshell.execDetached(["bash", Caching.serpantinumDir + "/scripts/qs_manager.sh", "close"]);
        }
    }

    function startExit(onFinished) {
        introAnim.stop();
        exitCallback = onFinished;
        exitAnim.restart();
    }

    function resetAndPlayIntro() {
        exitAnim.stop();
        introMain = 0;
        introHeader = 0;
        introContent = 0;
        introAnim.restart();
    }

    property real introMain: 0
    property real introHeader: 0
    property real introContent: 0

    ParallelAnimation {
        id: introAnim
        running: false
        NumberAnimation { target: window; property: "introMain"; from: 0; to: 1.0; duration: 420; easing.type: Easing.OutExpo }
        SequentialAnimation {
            PauseAnimation { duration: 60 }
            NumberAnimation { target: window; property: "introHeader"; from: 0; to: 1.0; duration: 400; easing.type: Easing.OutCubic }
        }
        SequentialAnimation {
            PauseAnimation { duration: 120 }
            NumberAnimation { target: window; property: "introContent"; from: 0; to: 1.0; duration: 460; easing.type: Easing.OutExpo }
        }
    }

    SequentialAnimation {
        id: exitAnim
        running: false
        ParallelAnimation {
            NumberAnimation { target: window; property: "introContent"; to: 0.0; duration: 120; easing.type: Easing.InCubic }
            SequentialAnimation {
                PauseAnimation { duration: 25 }
                NumberAnimation { target: window; property: "introHeader"; to: 0.0; duration: 130; easing.type: Easing.InCubic }
            }
            SequentialAnimation {
                PauseAnimation { duration: 40 }
                NumberAnimation { target: window; property: "introMain"; to: 0.0; duration: 130; easing.type: Easing.InQuart }
            }
        }
        ScriptAction {
            script: {
                if (window.exitCallback) {
                    let cb = window.exitCallback;
                    window.exitCallback = null;
                    cb();
                }
            }
        }
    }

    property string activeCategory: "All"
    property string searchQuery: ""
    property int selectedIndex: 0

    readonly property var categories: [
        { id: "All",         label: "All",         icon: "󰌌" },
        { id: "System",      label: "System",      icon: "󰒓" },
        { id: "Window",      label: "Window",      icon: "󱂬" },
        { id: "Navigation",  label: "Navigation",  icon: "󰁔" },
        { id: "Workspaces",  label: "Workspaces",  icon: "󰮯" },
        { id: "Serpantinum", label: "Serpantinum", icon: "󰀻" },
        { id: "Capture",     label: "Capture",     icon: "󰄀" },
        { id: "Media",       label: "Media",       icon: "󰎈" }
    ]

    function categoryColor(cat) {
        if (cat === "System") return ThemeBackend.blue;
        if (cat === "Window") return ThemeBackend.mauve;
        if (cat === "Navigation") return ThemeBackend.teal;
        if (cat === "Workspaces") return ThemeBackend.sapphire;
        if (cat === "Serpantinum") return ThemeBackend.peach;
        if (cat === "Capture") return ThemeBackend.green;
        if (cat === "Media") return ThemeBackend.pink;
        return ThemeBackend.blue;
    }

    function categoryIcon(cat) {
        for (let i = 0; i < categories.length; i++) {
            if (categories[i].id === cat) return categories[i].icon;
        }
        return "󰌌";
    }

    readonly property var allKeybinds: [
        // System & Apps
        { category: "System", keys: ["SUPER", "RETURN"],          title: "Launch Terminal",              subtitle: "Kitty",                           actionType: "cmd",    action: "kitty" },
        { category: "System", keys: ["SUPER", "SHIFT", "RETURN"], title: "Toggle Persistent Terminal",   subtitle: "Special scratchpad terminal",     actionType: "",       action: "" },
        { category: "System", keys: ["SUPER", "SPACE"],           title: "Application Launcher",         subtitle: "Also SUPER + D",                  actionType: "ipc",    action: "launcher" },
        { category: "System", keys: ["SUPER", "E"],               title: "Open File Manager",            subtitle: "Ski",                             actionType: "cmd",    action: "ski" },
        { category: "System", keys: ["SUPER", "ESC"],             title: "Lock Screen",                  subtitle: "Also SUPER + ALT + L / Power",    actionType: "cmd",    action: "serpantinum lock" },
        { category: "System", keys: ["SUPER", "M"],               title: "Session Exit / Shutdown",      subtitle: "hyprshutdown / exit Hyprland",    actionType: "cmd",    action: "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'" },
        { category: "System", keys: ["SUPER", "?"],               title: "Keybindings Help Menu",        subtitle: "Also SUPER + /",                  actionType: "",       action: "" },

        // Window Management
        { category: "Window", keys: ["SUPER", "C"],               title: "Close Active Window",          subtitle: "Kill focused client",             actionType: "",       action: "" },
        { category: "Window", keys: ["SUPER", "V"],               title: "Toggle Floating Window",       subtitle: "Switch tiled / floating",         actionType: "",       action: "" },
        { category: "Window", keys: ["SUPER", "P"],               title: "Toggle Pseudo-Tiling",         subtitle: "Dwindle pseudo mode",             actionType: "",       action: "" },
        { category: "Window", keys: ["SUPER", "R"],               title: "Toggle Split Direction",       subtitle: "Horizontal / vertical split",     actionType: "",       action: "" },
        { category: "Window", keys: ["SUPER", "LMB"],             title: "Drag / Move Window",           subtitle: "Hold mouse left button",          actionType: "",       action: "" },
        { category: "Window", keys: ["SUPER", "RMB"],             title: "Resize Window with Mouse",     subtitle: "Hold mouse right button",         actionType: "",       action: "" },

        // Vim Navigation
        { category: "Navigation", keys: ["SUPER", "H / J / K / L"],         title: "Focus Window",       subtitle: "Left / Down / Up / Right",        actionType: "",       action: "" },
        { category: "Navigation", keys: ["SUPER", "SHIFT", "H / J / K / L"], title: "Move Window",       subtitle: "Swap Left / Down / Up / Right",   actionType: "",       action: "" },
        { category: "Navigation", keys: ["SUPER", "ALT", "H / J / K / L"],  title: "Smart Resize Window", subtitle: "Tiled & centered floating step", actionType: "",       action: "" },

        // Workspaces
        { category: "Workspaces", keys: ["SUPER", "1..9 / 0"],           title: "Switch Workspace",          subtitle: "Focus desktop I – X",          actionType: "",       action: "" },
        { category: "Workspaces", keys: ["SUPER", "SHIFT", "1..9 / 0"],  title: "Move Window to Workspace",  subtitle: "Send client to desktop I – X", actionType: "",       action: "" },
        { category: "Workspaces", keys: ["SUPER", "SCROLL"],             title: "Cycle Workspaces",          subtitle: "Next / previous occupied",     actionType: "",       action: "" },

        // Serpantinum Shell
        { category: "Serpantinum", keys: ["SUPER", "SHIFT", "V"], title: "Clipboard History",            subtitle: "Also SUPER + Y",                  actionType: "ipc",    action: "clipboard" },
        { category: "Serpantinum", keys: ["SUPER", "N"],          title: "Notification Center",          subtitle: "Also SUPER + SHIFT + N",          actionType: "widget", action: "notifications" },
        { category: "Serpantinum", keys: ["SUPER", "B"],          title: "System Dashboard",             subtitle: "Also SUPER + I / SUPER + ALT + D", actionType: "widget", action: "system" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "C"],   title: "Calendar & Clock",             subtitle: "Toggle calendar dashboard",       actionType: "ipc",    action: "calendar" },
        { category: "Serpantinum", keys: ["SUPER", "SHIFT", "B"], title: "Wallpaper Picker",             subtitle: "Also SUPER + ALT + W",            actionType: "widget", action: "wallpaper" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "M"],   title: "Music Player",                 subtitle: "Media controls & lyrics",         actionType: "widget", action: "music" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "N"],   title: "Network & Bluetooth",          subtitle: "WiFi & device connections",       actionType: "widget", action: "network" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "V"],   title: "Volume & Audio",               subtitle: "Sinks, mics & app streams",       actionType: "widget", action: "volume" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "B"],   title: "Toggle Bar Autohide",          subtitle: "Show / autohide bar",             actionType: "cmd",    action: "serpantinum msg bar autohide" },
        { category: "Serpantinum", keys: ["SUPER", ","],          title: "Serpantinum Settings",         subtitle: "Open configuration guide",        actionType: "widget", action: "guide" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "E"],   title: "Widget Layout Editor",         subtitle: "Desktop widgets redactor",        actionType: "cmd",    action: "serpantinum redactor" },
        { category: "Serpantinum", keys: ["SUPER", "ALT", "R"],   title: "Reload Serpantinum",           subtitle: "Hot-reload desktop shell",        actionType: "cmd",    action: "serpantinum reload" },

        // Capture & Screenshots
        { category: "Capture", keys: ["SUPER", "S"],              title: "Region Screenshot",            subtitle: "Hyprshot → ~/Images/screenshots", actionType: "cmd",    action: "hyprshot -m region -o ~/Images/screenshots -c" },
        { category: "Capture", keys: ["SUPER", "SHIFT", "S"],     title: "Window Screenshot",            subtitle: "Hyprshot active window",          actionType: "cmd",    action: "hyprshot -m window ~/Images/screenshots -c" },
        { category: "Capture", keys: ["PRINT"],                   title: "Interactive Screenshot Editor", subtitle: "Serpantinum capture & edit",     actionType: "cmd",    action: "serpantinum screenshot --edit" },
        { category: "Capture", keys: ["SHIFT", "PRINT"],          title: "Quick Region Screenshot",      subtitle: "Serpantinum screenshot",          actionType: "cmd",    action: "serpantinum screenshot" },
        { category: "Capture", keys: ["SUPER", "PRINT"],          title: "Fullscreen Screenshot",        subtitle: "Also SUPER + SHIFT + PRINT to edit", actionType: "cmd", action: "serpantinum screenshot --full" },

        // Media & Hardware Keys
        { category: "Media", keys: ["VOL +", "VOL -"],            title: "Adjust Volume",                subtitle: "±5% default audio sink",          actionType: "",       action: "" },
        { category: "Media", keys: ["MUTE", "MIC MUTE"],          title: "Toggle Audio / Mic Mute",      subtitle: "WirePlumber default sink/source", actionType: "",       action: "" },
        { category: "Media", keys: ["BRI +", "BRI -"],            title: "Adjust Screen Brightness",     subtitle: "±5% via brightnessctl",           actionType: "",       action: "" },
        { category: "Media", keys: ["PLAY", "PREV", "NEXT"],      title: "Media Playback Controls",      subtitle: "playerctl play-pause / prev / next", actionType: "",    action: "" }
    ]

    ListModel {
        id: filteredModel
    }

    function rebuildFilter() {
        let q = String(searchQuery || "").trim().toLowerCase();
        let cat = activeCategory;
        let tokens = q !== "" ? q.split(/\s+/) : [];

        filteredModel.clear();
        for (let i = 0; i < allKeybinds.length; i++) {
            let item = allKeybinds[i];
            if (cat !== "All" && item.category !== cat) continue;

            if (tokens.length > 0) {
                let hay = (item.title + " " + item.subtitle + " " + item.category + " " + item.keys.join(" ")).toLowerCase();
                let ok = true;
                for (let t = 0; t < tokens.length; t++) {
                    if (hay.indexOf(tokens[t]) === -1) {
                        ok = false;
                        break;
                    }
                }
                if (!ok) continue;
            }

            filteredModel.append({
                category: item.category,
                title: item.title,
                subtitle: item.subtitle,
                keysJson: JSON.stringify(item.keys),
                actionType: item.actionType,
                action: item.action
            });
        }

        if (filteredModel.count > 0) {
            selectedIndex = 0;
            bindsList.currentIndex = 0;
        } else {
            selectedIndex = -1;
            bindsList.currentIndex = -1;
        }
    }

    function moveSelection(delta) {
        if (filteredModel.count <= 0) return;
        let next = (selectedIndex + delta + filteredModel.count) % filteredModel.count;
        selectedIndex = next;
        bindsList.currentIndex = next;
        bindsList.positionViewAtIndex(next, ListView.Contain);
    }

    function cycleCategory(delta) {
        let idx = 0;
        for (let i = 0; i < categories.length; i++) {
            if (categories[i].id === activeCategory) {
                idx = i;
                break;
            }
        }
        let next = (idx + delta + categories.length) % categories.length;
        activeCategory = categories[next].id;
        if (typeof Sounds !== "undefined") {
            Sounds.playSfx("reusables/clickbutton/click.wav");
        }
        rebuildFilter();
    }

    function runItem(item) {
        if (!item || !item.actionType || !item.action) {
            closePopup();
            return;
        }
        if (typeof Sounds !== "undefined") {
            Sounds.playSfx("reusables/clickbutton/click.wav");
        }

        if (item.actionType === "widget") {
            if (typeof masterWindow !== "undefined" && masterWindow.switchWidget) {
                masterWindow.switchWidget(item.action, "");
            } else {
                Quickshell.execDetached(["serpantinum", "msg", "open", item.action]);
            }
        } else if (item.actionType === "ipc") {
            closePopup();
            if (item.action === "launcher" && typeof LauncherController !== "undefined") {
                LauncherController.show();
            } else if (item.action === "clipboard" && typeof ClipboardController !== "undefined") {
                ClipboardController.show();
            } else if (item.action === "calendar" && typeof DashboardController !== "undefined") {
                DashboardController.show();
            } else {
                Quickshell.execDetached(["serpantinum", "msg", "open", item.action]);
            }
        } else if (item.actionType === "cmd") {
            let cmd = item.action;
            closePopup();
            Quickshell.execDetached(["bash", "-c", cmd]);
        }
    }

    function activateCurrent() {
        if (selectedIndex >= 0 && selectedIndex < filteredModel.count) {
            runItem(filteredModel.get(selectedIndex));
        }
    }

    Timer {
        id: focusTimer
        interval: 60
        repeat: false
        onTriggered: {
            if (window.visible) {
                searchInput.forceInputFocus();
            }
        }
    }

    onVisibleChanged: {
        if (visible) {
            if (typeof LauncherController !== "undefined") LauncherController.hide();
            if (typeof ClipboardController !== "undefined") ClipboardController.hide();
            activeCategory = "All";
            searchQuery = "";
            searchInput.text = "";
            rebuildFilter();
            resetAndPlayIntro();
            focusTimer.restart();
        } else {
            introAnim.stop();
            exitAnim.stop();
            introMain = 0;
            introHeader = 0;
            introContent = 0;
        }
    }

    Component.onCompleted: {
        rebuildFilter();
        if (visible) {
            resetAndPlayIntro();
            focusTimer.restart();
        }
    }

    Shortcut { sequence: "Down";    context: Qt.WindowShortcut; enabled: window.visible; onActivated: window.moveSelection(1) }
    Shortcut { sequence: "Up";      context: Qt.WindowShortcut; enabled: window.visible; onActivated: window.moveSelection(-1) }
    Shortcut { sequence: "Ctrl+N";  context: Qt.WindowShortcut; enabled: window.visible; onActivated: window.moveSelection(1) }
    Shortcut { sequence: "Ctrl+P";  context: Qt.WindowShortcut; enabled: window.visible; onActivated: window.moveSelection(-1) }
    Shortcut { sequence: "Tab";     context: Qt.WindowShortcut; enabled: window.visible; onActivated: window.cycleCategory(1) }
    Shortcut { sequence: "Backtab"; context: Qt.WindowShortcut; enabled: window.visible; onActivated: window.cycleCategory(-1) }
    Shortcut { sequence: "Return";  context: Qt.WindowShortcut; enabled: window.visible && !searchInput.hasFocus; onActivated: window.activateCurrent() }
    Shortcut { sequence: "Enter";   context: Qt.WindowShortcut; enabled: window.visible && !searchInput.hasFocus; onActivated: window.activateCurrent() }

    Item {
        anchors.fill: parent
        scale: 0.96 + (0.04 * introMain)
        opacity: introMain
        transform: Translate { y: window.s(18) * (1 - introMain) }

        Rectangle {
            id: panelBg
            anchors.fill: parent
            radius: ThemeBackend.borderRadius
            color: Qt.alpha(ThemeBackend.base, ThemeBackend.elementOpacity)
            border.width: 1
            border.color: Qt.alpha(ThemeBackend.surface2, 0.45)
            clip: true

            WallpaperBlur {
                z: -1
                anchors.fill: parent
                radius: parent.radius
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: window.s(20)
                spacing: window.s(14)

                // Header
                RowLayout {
                    Layout.fillWidth: true
                    spacing: window.s(12)
                    opacity: introHeader
                    transform: Translate { y: window.s(14) * (1.0 - introHeader) }

                    Rectangle {
                        Layout.preferredWidth: window.s(38)
                        Layout.preferredHeight: window.s(38)
                        radius: Math.max(6, ThemeBackend.borderRadius - 2)
                        color: Qt.alpha(ThemeBackend.blue, 0.16)
                        border.width: 1
                        border.color: Qt.alpha(ThemeBackend.blue, 0.35)

                        Text {
                            anchors.centerIn: parent
                            text: "󰌌"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(20)
                            color: ThemeBackend.blue
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: window.s(2)

                        Text {
                            text: "Keybindings"
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(18)
                            font.weight: Font.Black
                            color: ThemeBackend.text
                        }

                        Text {
                            text: filteredModel.count + (filteredModel.count === 1 ? " shortcut" : " shortcuts") + "  •  Hyprland & Serpantinum"
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(11)
                            color: ThemeBackend.subtext0
                        }
                    }

                    CloseButton {
                        size: window.s(30)
                        onClicked: window.closePopup()
                    }
                }

                // Search input
                Input {
                    id: searchInput
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.s(40)
                    cornerRadius: Math.max(6, ThemeBackend.borderRadius - 2)
                    horizontalPadding: window.s(12)
                    fontPixelSize: window.s(13)
                    leadingIcon: "󰍉"
                    showClearButton: true
                    unfocusOnOutsideClick: false
                    placeholderText: "Search keybindings, keys, or actions..."
                    baseColor: ThemeBackend.surface0
                    accentColor: ThemeBackend.blue
                    opacity: introHeader
                    transform: Translate { y: window.s(10) * (1.0 - introHeader) }

                    onTextEdited: (newText) => {
                        window.searchQuery = newText;
                        window.rebuildFilter();
                    }
                    onCleared: {
                        window.searchQuery = "";
                        window.rebuildFilter();
                    }
                    onAccepted: {
                        window.activateCurrent();
                    }
                }

                // Category filter chips
                Flickable {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.s(32)
                    contentWidth: catRow.implicitWidth
                    contentHeight: height
                    clip: true
                    boundsBehavior: Flickable.StopAtBounds
                    opacity: introHeader

                    Row {
                        id: catRow
                        spacing: window.s(6)
                        height: parent.height

                        Repeater {
                            model: window.categories

                            Rectangle {
                                id: catChip
                                required property var modelData
                                readonly property bool isActive: window.activeCategory === modelData.id
                                readonly property color chipAccent: window.categoryColor(modelData.id)

                                height: window.s(30)
                                width: chipInner.implicitWidth + window.s(20)
                                radius: Math.max(6, ThemeBackend.borderRadius - 2)
                                color: isActive
                                    ? chipAccent
                                    : (chipMa.containsMouse ? Qt.lighter(ThemeBackend.surface0, 1.18) : ThemeBackend.surface0)
                                border.width: 1
                                border.color: isActive ? chipAccent : Qt.alpha(ThemeBackend.surface2, 0.35)

                                Behavior on color { ColorAnimation { duration: 150 } }

                                Row {
                                    id: chipInner
                                    anchors.centerIn: parent
                                    spacing: window.s(6)

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: catChip.modelData.icon
                                        font.family: ThemeBackend.iconFont
                                        font.pixelSize: window.s(13)
                                        color: catChip.isActive ? ThemeBackend.crust : catChip.chipAccent
                                    }

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: catChip.modelData.label
                                        font.family: ThemeBackend.fontFamily
                                        font.pixelSize: window.s(11)
                                        font.bold: true
                                        color: catChip.isActive ? ThemeBackend.crust : ThemeBackend.text
                                    }
                                }

                                MouseArea {
                                    id: chipMa
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        if (typeof Sounds !== "undefined") {
                                            Sounds.playSfx("reusables/clickbutton/click.wav");
                                        }
                                        window.activeCategory = catChip.modelData.id;
                                        window.rebuildFilter();
                                        searchInput.forceInputFocus();
                                    }
                                }
                            }
                        }
                    }
                }

                // Keybindings list
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    opacity: introContent
                    transform: Translate { y: window.s(14) * (1.0 - introContent) }

                    ListView {
                        id: bindsList
                        anchors.fill: parent
                        clip: true
                        spacing: window.s(6)
                        model: filteredModel
                        currentIndex: window.selectedIndex
                        boundsBehavior: Flickable.StopAtBounds

                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded
                            width: window.s(5)
                            contentItem: Rectangle {
                                radius: width / 2
                                color: Qt.alpha(ThemeBackend.surface2, 0.85)
                            }
                        }

                        delegate: Rectangle {
                            id: bindRow
                            required property int index
                            required property string category
                            required property string title
                            required property string subtitle
                            required property string keysJson
                            required property string actionType
                            required property string action

                            readonly property bool isSelected: index === window.selectedIndex
                            readonly property bool isActionable: actionType !== "" && action !== ""
                            readonly property color catColor: window.categoryColor(category)
                            readonly property var keyParts: {
                                try {
                                    return JSON.parse(keysJson);
                                } catch (e) {
                                    return [];
                                }
                            }

                            width: bindsList.width - window.s(8)
                            height: window.s(52)
                            radius: Math.max(6, ThemeBackend.borderRadius - 2)
                            color: isSelected
                                ? Qt.alpha(catColor, 0.14)
                                : (rowMa.containsMouse ? Qt.alpha(ThemeBackend.surface1, 0.65) : Qt.alpha(ThemeBackend.surface0, 0.55))
                            border.width: 1
                            border.color: isSelected
                                ? Qt.alpha(catColor, 0.65)
                                : (rowMa.containsMouse ? Qt.alpha(ThemeBackend.surface2, 0.6) : Qt.alpha(ThemeBackend.surface1, 0.35))

                            Behavior on color { ColorAnimation { duration: 130 } }
                            Behavior on border.color { ColorAnimation { duration: 130 } }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: window.s(12)
                                anchors.rightMargin: window.s(12)
                                spacing: window.s(12)

                                // Category icon pill
                                Rectangle {
                                    Layout.preferredWidth: window.s(30)
                                    Layout.preferredHeight: window.s(30)
                                    radius: Math.max(5, ThemeBackend.borderRadius - 4)
                                    color: Qt.alpha(bindRow.catColor, 0.16)

                                    Text {
                                        anchors.centerIn: parent
                                        text: window.categoryIcon(bindRow.category)
                                        font.family: ThemeBackend.iconFont
                                        font.pixelSize: window.s(14)
                                        color: bindRow.catColor
                                    }
                                }

                                // Title & subtitle
                                ColumnLayout {
                                    Layout.fillWidth: true
                                    spacing: window.s(2)

                                    RowLayout {
                                        spacing: window.s(8)

                                        Text {
                                            text: bindRow.title
                                            font.family: ThemeBackend.fontFamily
                                            font.pixelSize: window.s(13)
                                            font.bold: true
                                            color: ThemeBackend.text
                                            elide: Text.ElideRight
                                        }

                                        Rectangle {
                                            visible: bindRow.isActionable && (bindRow.isSelected || rowMa.containsMouse)
                                            Layout.preferredHeight: window.s(16)
                                            Layout.preferredWidth: runBadgeTxt.implicitWidth + window.s(10)
                                            radius: window.s(4)
                                            color: Qt.alpha(bindRow.catColor, 0.22)

                                            Text {
                                                id: runBadgeTxt
                                                anchors.centerIn: parent
                                                text: "↵ Run"
                                                font.family: ThemeBackend.fontFamily
                                                font.pixelSize: window.s(9)
                                                font.bold: true
                                                color: bindRow.catColor
                                            }
                                        }
                                    }

                                    Text {
                                        Layout.fillWidth: true
                                        text: bindRow.category + (bindRow.subtitle !== "" ? ("  ·  " + bindRow.subtitle) : "")
                                        font.family: ThemeBackend.fontFamily
                                        font.pixelSize: window.s(10)
                                        color: ThemeBackend.subtext0
                                        elide: Text.ElideRight
                                    }
                                }

                                // Styled keycaps
                                Row {
                                    Layout.alignment: Qt.AlignVCenter
                                    spacing: window.s(4)

                                    Repeater {
                                        model: bindRow.keyParts

                                        Row {
                                            required property int index
                                            required property string modelData
                                            spacing: window.s(4)

                                            Text {
                                                visible: index > 0
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: "+"
                                                font.family: ThemeBackend.fontFamily
                                                font.pixelSize: window.s(10)
                                                font.bold: true
                                                color: ThemeBackend.subtext0
                                            }

                                            Rectangle {
                                                readonly property bool isMod: modelData === "SUPER" || modelData === "SHIFT" || modelData === "ALT" || modelData === "CTRL"
                                                height: window.s(26)
                                                width: Math.max(window.s(28), keyTxt.implicitWidth + window.s(14))
                                                radius: window.s(6)
                                                color: isMod
                                                    ? Qt.alpha(bindRow.catColor, 0.18)
                                                    : ThemeBackend.surface1
                                                border.width: 1
                                                border.color: isMod
                                                    ? Qt.alpha(bindRow.catColor, 0.45)
                                                    : Qt.alpha(ThemeBackend.surface2, 0.7)

                                                Text {
                                                    id: keyTxt
                                                    anchors.centerIn: parent
                                                    text: modelData
                                                    font.family: ThemeBackend.fontFamily
                                                    font.pixelSize: window.s(11)
                                                    font.weight: Font.Black
                                                    color: parent.isMod ? bindRow.catColor : ThemeBackend.text
                                                }
                                            }
                                        }
                                    }
                                }
                            }

                            MouseArea {
                                id: rowMa
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: bindRow.isActionable ? Qt.PointingHandCursor : Qt.ArrowCursor
                                onEntered: {
                                    window.selectedIndex = bindRow.index;
                                    bindsList.currentIndex = bindRow.index;
                                }
                                onClicked: {
                                    window.selectedIndex = bindRow.index;
                                    if (bindRow.isActionable) {
                                        window.runItem(filteredModel.get(bindRow.index));
                                    }
                                }
                            }
                        }
                    }

                    // Empty search state
                    Column {
                        anchors.centerIn: parent
                        visible: filteredModel.count === 0
                        spacing: window.s(8)

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "󰍉"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(28)
                            color: ThemeBackend.subtext0
                        }

                        Text {
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "No matching keybindings"
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(13)
                            font.bold: true
                            color: ThemeBackend.subtext0
                        }
                    }
                }

                // Footer key hints
                RowLayout {
                    Layout.fillWidth: true
                    spacing: window.s(16)
                    opacity: introContent

                    Text {
                        text: "↑↓ Navigate   ·   ↵ Run action   ·   Tab Category   ·   Esc Close"
                        font.family: ThemeBackend.fontFamily
                        font.pixelSize: window.s(11)
                        color: ThemeBackend.subtext0
                    }

                    Item { Layout.fillWidth: true }

                    Text {
                        text: "SUPER + ?"
                        font.family: ThemeBackend.fontFamily
                        font.pixelSize: window.s(11)
                        font.bold: true
                        color: ThemeBackend.blue
                    }
                }
            }
        }
    }
}
