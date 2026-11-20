import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../../reusables"
import "../../../"

Item {
    id: romanFaceRoot
    property var widget: null

    readonly property bool isVertical: widget ? widget.orientation === "vertical" : false

    property real pillSize: widget ? widget.s(widget.isCompact ? 20 : 24) : 24
    property real pillPadX: widget ? widget.s(widget.isCompact ? 5 : 6) : 6
    property real pillRadius: widget ? widget.s(widget.isCompact ? 6 : 7) : 7
    property real layoutSpacing: widget ? widget.s(widget.isCompact ? 5 : 6) : 6

    function toRoman(num) {
        if (num <= 0) return String(num);
        const vals = [100, 90, 50, 40, 10, 9, 5, 4, 1];
        const syms = ["C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
        let n = num;
        let out = "";
        for (let i = 0; i < vals.length; i++) {
            while (n >= vals[i]) {
                out += syms[i];
                n -= vals[i];
            }
        }
        return out;
    }

    function isShown(index) {
        if (!widget)
            return false;
        if (typeof widget.isShown === "function")
            return widget.isShown(index);
        return true;
    }

    readonly property var shownIndices: {
        if (!widget)
            return [];
        widget.activeIndex;
        widget.workspaceCount;
        widget.hideEmptyWorkspaces;
        widget.niriOccupiedMap;
        widget.swayOccupiedMap;
        widget.mangoOccupiedMap;
        if (Compositor.name === "hyprland")
            Hyprland.workspaces.values;
        let ids = [];
        for (let i = 0; i < widget.workspaceCount; i++) {
            if (isShown(i))
                ids.push(i);
        }
        return ids;
    }

    implicitWidth: wsLayout.implicitWidth
    implicitHeight: wsLayout.implicitHeight

    Rectangle {
        id: activeHighlight
        z: 0
        x: romanFaceRoot.isVertical ? wsLayout.x + (wsLayout.width - width) / 2 : actualStart
        y: romanFaceRoot.isVertical ? actualStart : wsLayout.y + (wsLayout.height - height) / 2
        width: romanFaceRoot.isVertical ? romanFaceRoot.pillSize : Math.max(0, actualEnd - actualStart)
        height: romanFaceRoot.isVertical ? Math.max(0, actualEnd - actualStart) : romanFaceRoot.pillSize
        radius: romanFaceRoot.pillRadius
        color: romanGlass.active ? "transparent" : ((widget && widget.isCompact) ? Qt.lighter(ThemeBackend.mauve, 1.05) : ThemeBackend.mauve)

        GlassFill {
            id: romanGlass
            anchors.fill: parent
            radius: parent.radius
            tintColor: ThemeBackend.mauve
            tintAmount: 0.5
            press: 0.3 + 0.7 * activeHighlight.lift
        }

        property int prevIdx: 0
        property int curIdx: widget ? widget.activeIndex : -1

        onCurIdxChanged: {
            if (curIdx >= 0 && prevIdx >= 0) {
                if (curIdx > prevIdx) {
                    endAnim.duration = 200;
                    startAnim.duration = 350;
                } else if (curIdx < prevIdx) {
                    startAnim.duration = 200;
                    endAnim.duration = 350;
                }
            }
            if (curIdx >= 0) {
                prevIdx = curIdx;
            }
        }

        readonly property Item activeItem: {
            romanFaceRoot.shownIndices;
            void wsRepeater.count;
            return (curIdx >= 0 && curIdx < wsRepeater.count) ? wsRepeater.itemAt(curIdx) : null;
        }

        property real targetStart: {
            romanFaceRoot.shownIndices;
            if (!activeItem) return 0;
            return romanFaceRoot.isVertical
                ? (wsLayout.y + activeItem.y)
                : (wsLayout.x + activeItem.x);
        }
        property real targetEnd: {
            romanFaceRoot.shownIndices;
            if (!activeItem) return 0;
            return romanFaceRoot.isVertical
                ? (wsLayout.y + activeItem.y + activeItem.height)
                : (wsLayout.x + activeItem.x + activeItem.width);
        }

        property real actualStart: targetStart
        property real actualEnd: targetEnd

        Behavior on actualStart { NumberAnimation { id: startAnim; duration: 250; easing.type: Easing.OutExpo } }
        Behavior on actualEnd { NumberAnimation { id: endAnim; duration: 250; easing.type: Easing.OutExpo } }

        readonly property bool isMoving: Math.abs(actualStart - targetStart) > 0.5 || Math.abs(actualEnd - targetEnd) > 0.5
        property real lift: (romanGlass.active && isMoving) ? 1.0 : 0.0
        Behavior on lift { NumberAnimation { duration: 250; easing.type: Easing.OutCubic } }
        scale: 1.0 + 0.14 * lift
        transformOrigin: Item.Center

        opacity: (widget && widget.workspaceCount > 0 && widget.activeIndex >= 0 && activeItem) ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 250 } }
    }

    AxisFlow {
        id: wsLayout
        vertical: romanFaceRoot.isVertical
        z: 1
        anchors.centerIn: parent
        spacing: romanFaceRoot.layoutSpacing

        Repeater {
            id: wsRepeater
            model: widget ? widget.workspaceCount : 0

            delegate: Item {
                id: wsPill
                required property int index

                property bool isOccupied: widget ? widget.isOccupied(index) : false
                property bool isActive: widget ? (index === widget.activeIndex) : false
                property bool isHovered: wsPillMouse.containsMouse
                property bool initAnimTrigger: false
                property bool shown: romanFaceRoot.isShown(index)
                readonly property real dynamicWidth: Math.max(romanFaceRoot.pillSize, Math.ceil(wsLabel.implicitWidth + romanFaceRoot.pillPadX * 2))

                visible: shown
                width: romanFaceRoot.isVertical ? romanFaceRoot.pillSize : (shown ? dynamicWidth : 0)
                height: romanFaceRoot.isVertical ? (shown ? romanFaceRoot.pillSize : 0) : romanFaceRoot.pillSize

                Rectangle {
                    anchors.fill: parent
                    radius: romanFaceRoot.pillRadius
                    color: romanHoverGlass.active ? "transparent" : wsPill.isHovered
                        ? Qt.alpha(ThemeBackend.text, 0.1)
                        : (wsPill.isActive ? "transparent" : (wsPill.isOccupied ? Qt.alpha(ThemeBackend.text, 0.15) : "transparent"))

                    Behavior on color { ColorAnimation { duration: 250 } }

                    scale: wsPill.isHovered && !wsPill.isActive ? 1.08 : 1.0
                    Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutBack } }

                    GlassFill {
                        id: romanHoverGlass
                        anchors.fill: parent
                        radius: parent.radius
                        allowed: wsPill.isHovered && !wsPill.isActive
                        tintColor: ThemeBackend.text
                        tintAmount: 0.15
                        press: wsPillMouse.pressed ? 0.8 : 0.25
                    }
                }

                opacity: initAnimTrigger ? 1.0 : 0.0
                transform: Translate {
                    x: (!romanFaceRoot.isVertical || wsPill.initAnimTrigger) ? 0 : (widget ? widget.s(15) : 15)
                    y: (romanFaceRoot.isVertical || wsPill.initAnimTrigger) ? 0 : (widget ? widget.s(15) : 15)
                    Behavior on x { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }
                    Behavior on y { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }
                }

                Component.onCompleted: {
                    if (widget && widget.barWindow && !widget.barWindow.startupCascadeFinished) {
                        animTimer.interval = index * 60;
                        if (widget.moduleActive) animTimer.start();
                    } else {
                        initAnimTrigger = true;
                    }
                }

                Timer {
                    id: animTimer
                    running: false
                    repeat: false
                    onTriggered: wsPill.initAnimTrigger = true
                }

                Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.OutCubic } }

                Text {
                    id: wsLabel
                    anchors.centerIn: parent
                    width: romanFaceRoot.isVertical ? (parent.width - 2) : undefined
                    text: romanFaceRoot.toRoman(wsPill.index + 1)
                    font.family: ThemeBackend.fontFamily !== "" ? ThemeBackend.fontFamily : "JetBrains Mono"
                    font.pixelSize: widget ? widget.s(widget.isCompact ? 12 : 14) : 14
                    fontSizeMode: romanFaceRoot.isVertical ? Text.HorizontalFit : Text.FixedSize
                    minimumPixelSize: 7
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.weight: wsPill.isActive ? Font.Black : (wsPill.isOccupied ? Font.Bold : Font.Medium)

                    color: wsPill.isActive
                        ? (romanGlass.active ? ThemeBackend.text : ThemeBackend.crust)
                        : (wsPill.isHovered
                            ? ThemeBackend.text
                            : (wsPill.isOccupied
                                ? ThemeBackend.text
                                : (ThemeBackend.overlay0 !== undefined ? ThemeBackend.overlay0 : ThemeBackend.subtext0)))

                    Behavior on color { ColorAnimation { duration: 250 } }
                }

                MouseArea {
                    id: wsPillMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (widget) widget.focusWorkspace(wsPill.index);
                    }
                }
            }
        }
    }
}
