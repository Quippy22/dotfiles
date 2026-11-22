import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import "../"
import "../reusables"

Item {
    id: window
    visible: false
    focus: true

    function s(val) {
        return (typeof Scaler !== "undefined") ? Scaler.s(val) : val;
    }

    property var exitCallback: null

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

    Timer {
        id: focusTimer
        interval: 50
        repeat: false
        onTriggered: window.forceActiveFocus()
    }

    onVisibleChanged: {
        if (visible) {
            forceActiveFocus();
            focusTimer.restart();
            resetAndPlayIntro();
            if ((!UpdatesState.packagesList || UpdatesState.packagesList.length === 0) && UpdatesState.updateCount > 0) {
                UpdatesState.checkNow();
            }
        } else {
            introAnim.stop();
            exitAnim.stop();
            introMain = 0;
            introHeader = 0;
            introContent = 0;
        }
    }

    Component.onCompleted: {
        if (visible) {
            forceActiveFocus();
            focusTimer.restart();
            resetAndPlayIntro();
        }
    }

    property real introMain: 0
    property real introHeader: 0
    property real introContent: 0

    ParallelAnimation {
        id: introAnim
        running: false
        NumberAnimation { target: window; property: "introMain"; from: 0; to: 1.0; duration: 400; easing.type: Easing.OutCubic }
        SequentialAnimation {
            PauseAnimation { duration: 60 }
            NumberAnimation { target: window; property: "introHeader"; from: 0; to: 1.0; duration: 400; easing.type: Easing.OutBack; easing.overshoot: 1.1 }
        }
        SequentialAnimation {
            PauseAnimation { duration: 120 }
            NumberAnimation { target: window; property: "introContent"; from: 0; to: 1.0; duration: 450; easing.type: Easing.OutCubic }
        }
    }

    SequentialAnimation {
        id: exitAnim
        running: false
        ParallelAnimation {
            NumberAnimation { target: window; property: "introContent"; to: 0.0; duration: 140; easing.type: Easing.InCubic }
            NumberAnimation { target: window; property: "introHeader"; to: 0.0; duration: 150; easing.type: Easing.InCubic }
            NumberAnimation { target: window; property: "introMain"; to: 0.0; duration: 160; easing.type: Easing.InCubic }
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

    Item {
        anchors.fill: parent
        scale: 0.96 + (0.04 * introMain)
        opacity: introMain
        transform: Translate { y: window.s(15) * (1 - introMain) }

        Rectangle {
            id: cardBackground
            anchors.fill: parent
            radius: ThemeBackend.borderRadius
            color: Qt.alpha(ThemeBackend.base, ThemeBackend.elementOpacity)
            border.color: Qt.alpha(ThemeBackend.surface1, 0.7)
            border.width: window.s(1)
            clip: true

            WallpaperBlur {
                z: -1
                anchors.fill: parent
                radius: parent.radius
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: window.s(14)
                spacing: window.s(12)

                // Header Row
                RowLayout {
                    Layout.fillWidth: true
                    spacing: window.s(10)
                    opacity: introHeader
                    transform: Translate { y: window.s(10) * (1.0 - introHeader) }

                    Rectangle {
                        Layout.preferredWidth: window.s(36)
                        Layout.preferredHeight: window.s(36)
                        radius: window.s(10)
                        color: Qt.alpha(ThemeBackend.peach, 0.15)
                        border.color: Qt.alpha(ThemeBackend.peach, 0.35)
                        border.width: window.s(1)

                        Text {
                            anchors.centerIn: parent
                            text: "󰁝"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(20)
                            color: ThemeBackend.peach
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: window.s(1)

                        Text {
                            text: typeof I18n !== "undefined" ? I18n.t("updates.title", "System Updates") : "System Updates"
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(15)
                            font.bold: true
                            color: ThemeBackend.text
                        }

                        Text {
                            text: UpdatesState.updateCount > 0
                                ? (UpdatesState.updateCount + " " + (UpdatesState.updateCount === 1 ? "package update available" : "package updates available"))
                                : "System is up to date"
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(11.5)
                            color: ThemeBackend.subtext0
                        }
                    }

                    // Refresh Button
                    Rectangle {
                        Layout.preferredWidth: window.s(32)
                        Layout.preferredHeight: window.s(32)
                        radius: window.s(8)
                        color: refreshMa.containsMouse ? Qt.alpha(ThemeBackend.surface1, 0.8) : Qt.alpha(ThemeBackend.surface0, 0.5)

                        Text {
                            id: refreshIcon
                            anchors.centerIn: parent
                            text: "󰑐"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(16)
                            color: refreshMa.containsMouse ? ThemeBackend.text : ThemeBackend.subtext0

                            RotationAnimation on rotation {
                                running: UpdatesState.isChecking
                                loops: Animation.Infinite
                                from: 0
                                to: 360
                                duration: 800
                            }
                        }

                        MouseArea {
                            id: refreshMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: UpdatesState.checkNow()
                        }
                    }

                    // Close Button
                    Rectangle {
                        Layout.preferredWidth: window.s(32)
                        Layout.preferredHeight: window.s(32)
                        radius: window.s(8)
                        color: closeMa.containsMouse ? Qt.alpha(ThemeBackend.surface1, 0.8) : Qt.alpha(ThemeBackend.surface0, 0.5)

                        Text {
                            anchors.centerIn: parent
                            text: "󰅖"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(16)
                            color: closeMa.containsMouse ? ThemeBackend.red : ThemeBackend.subtext0
                        }

                        MouseArea {
                            id: closeMa
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Quickshell.execDetached(["bash", "-c", Caching.serpantinumDir + "/scripts/qs_manager.sh close updates"])
                        }
                    }
                }

                // Divider
                Rectangle {
                    Layout.fillWidth: true
                    height: window.s(1)
                    color: Qt.alpha(ThemeBackend.surface1, 0.45)
                }

                // Packages List Content
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    opacity: introContent

                    // Empty State
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: window.s(8)
                        visible: !UpdatesState.isChecking && UpdatesState.updateCount === 0

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "󰄬"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(36)
                            color: ThemeBackend.green
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "All packages are up to date!"
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(13)
                            font.bold: true
                            color: ThemeBackend.text
                        }
                    }

                    // Loading State
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: window.s(8)
                        visible: UpdatesState.isChecking && (!UpdatesState.packagesList || UpdatesState.packagesList.length === 0)

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "󰑐"
                            font.family: ThemeBackend.iconFont
                            font.pixelSize: window.s(32)
                            color: ThemeBackend.peach

                            RotationAnimation on rotation {
                                running: true
                                loops: Animation.Infinite
                                from: 0
                                to: 360
                                duration: 900
                            }
                        }

                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            text: "Checking for updates..."
                            font.family: ThemeBackend.fontFamily
                            font.pixelSize: window.s(12)
                            color: ThemeBackend.subtext0
                        }
                    }

                    // ListView
                    ListView {
                        id: pkgListView
                        anchors.fill: parent
                        visible: UpdatesState.packagesList && UpdatesState.packagesList.length > 0
                        model: UpdatesState.packagesList
                        clip: true
                        spacing: window.s(4)
                        boundsBehavior: Flickable.StopAtBounds

                        ScrollBar.vertical: ScrollBar {
                            policy: ScrollBar.AsNeeded
                            width: window.s(4)
                        }

                        delegate: Rectangle {
                            id: pkgRow
                            width: pkgListView.width - window.s(6)
                            height: window.s(42)
                            radius: Math.max(0, ThemeBackend.borderRadius - window.s(4))
                            color: rowMa.containsMouse ? Qt.alpha(ThemeBackend.surface0, 0.9) : Qt.alpha(ThemeBackend.surface0, 0.35)
                            border.color: rowMa.containsMouse ? Qt.alpha(ThemeBackend.surface1, 0.6) : "transparent"
                            border.width: window.s(1)
                            Behavior on color { ColorAnimation { duration: 120 } }

                            MouseArea {
                                id: rowMa
                                anchors.fill: parent
                                hoverEnabled: true
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: window.s(10)
                                anchors.rightMargin: window.s(10)
                                spacing: window.s(8)

                                Text {
                                    text: "󰏓"
                                    font.family: ThemeBackend.iconFont
                                    font.pixelSize: window.s(16)
                                    color: ThemeBackend.peach
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                ColumnLayout {
                                    Layout.fillWidth: true
                                    Layout.alignment: Qt.AlignVCenter
                                    spacing: window.s(1)

                                    Text {
                                        text: modelData.name || ""
                                        font.family: ThemeBackend.fontFamily
                                        font.pixelSize: window.s(12.5)
                                        font.bold: true
                                        color: ThemeBackend.text
                                        elide: Text.ElideRight
                                        Layout.fillWidth: true
                                    }

                                    RowLayout {
                                        spacing: window.s(4)
                                        Layout.fillWidth: true

                                        Text {
                                            text: modelData.oldVersion || ""
                                            font.family: ThemeBackend.fontFamily
                                            font.pixelSize: window.s(10.5)
                                            color: ThemeBackend.subtext0
                                        }

                                        Text {
                                            visible: (modelData.oldVersion !== "" && modelData.newVersion !== "")
                                            text: "→"
                                            font.family: ThemeBackend.fontFamily
                                            font.pixelSize: window.s(10)
                                            color: ThemeBackend.overlay1
                                        }

                                        Text {
                                            text: modelData.newVersion || ""
                                            font.family: ThemeBackend.fontFamily
                                            font.pixelSize: window.s(10.5)
                                            font.bold: true
                                            color: ThemeBackend.green
                                        }

                                        Item { Layout.fillWidth: true }

                                        Rectangle {
                                            visible: modelData.extra && modelData.extra !== ""
                                            Layout.preferredHeight: window.s(16)
                                            Layout.preferredWidth: extraLabel.implicitWidth + window.s(8)
                                            radius: window.s(4)
                                            color: Qt.alpha(ThemeBackend.surface1, 0.7)

                                            Text {
                                                id: extraLabel
                                                anchors.centerIn: parent
                                                text: modelData.extra || ""
                                                font.family: ThemeBackend.fontFamily
                                                font.pixelSize: window.s(9)
                                                color: ThemeBackend.subtext1
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                // Divider
                Rectangle {
                    Layout.fillWidth: true
                    height: window.s(1)
                    color: Qt.alpha(ThemeBackend.surface1, 0.45)
                }

                // Footer: Update Button
                ClickButton {
                    id: updateActionBtn
                    Layout.fillWidth: true
                    height: window.s(38)
                    cornerRadius: ThemeBackend.borderRadius
                    buttonIcon: "󰁝"
                    iconFontSize: window.s(16)
                    buttonText: UpdatesState.updateCount > 0 ? ("Update Now (" + UpdatesState.updateCount + ")") : "Run System Update"
                    textFontSize: window.s(13)
                    accentColor: ThemeBackend.peach
                    textColor: ThemeBackend.base
                    contentAlignment: Qt.AlignHCenter
                    onClicked: {
                        UpdatesState.launchUpdater();
                        Quickshell.execDetached(["bash", "-c", Caching.serpantinumDir + "/scripts/qs_manager.sh close updates"]);
                    }
                }
            }
        }
    }
}
