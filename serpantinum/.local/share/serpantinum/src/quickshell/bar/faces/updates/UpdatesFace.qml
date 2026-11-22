import QtQuick
import QtQuick.Layouts
import QtQuick.Window
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../../../reusables"
import "../../../"
import "../../"

BarFaceBase {
    id: root

    property string updatesStyle: {
        if (widget && widget !== root && widget.updatesStyle !== undefined) return widget.updatesStyle;
        if (module && module.updatesStyle !== undefined) return module.updatesStyle;
        let dummy = configRevision;
        if (typeof Config !== "undefined" && Config.rawSettings && Config.rawSettings.bar) {
            let bs = Config.rawSettings.bar;
            if (bs.updatesStyle) return bs.updatesStyle;
            if (bs.updates && bs.updates.style) return bs.updates.style;
        }
        return "text";
    }

    property bool showIcon: {
        if (widget && widget !== root && widget.updatesShowIcon !== undefined) return widget.updatesShowIcon;
        if (widget && widget !== root && widget.showIcon !== undefined) return widget.showIcon;
        if (module && module.updatesShowIcon !== undefined) return module.updatesShowIcon;
        if (module && module.showIcon !== undefined) return module.showIcon;
        let dummy = configRevision;
        if (typeof Config !== "undefined" && Config.rawSettings && Config.rawSettings.bar) {
            let bs = Config.rawSettings.bar;
            if (bs.updatesShowIcon !== undefined) return Boolean(bs.updatesShowIcon);
            if (bs.updates && bs.updates.showIcon !== undefined) return Boolean(bs.updates.showIcon);
        }
        return true;
    }

    property bool hideWhenZero: {
        let dummy = configRevision;
        if (typeof Config !== "undefined" && Config.rawSettings && Config.rawSettings.bar) {
            let bs = Config.rawSettings.bar;
            if (bs.updatesHideWhenZero !== undefined) return Boolean(bs.updatesHideWhenZero);
            if (bs.updates && bs.updates.hideWhenZero !== undefined) return Boolean(bs.updates.hideWhenZero);
        }
        return false;
    }

    readonly property bool lockLook: activeTarget ? activeTarget.lockLook === true : false
    readonly property int updateCount: isPreview ? 12 : UpdatesState.updateCount
    readonly property string updateCountStr: updateCount.toString()
    property bool showLayout: (!barWindow || isPreview) ? true : false
    readonly property var updatesPill: pillLoader.item

    readonly property real pillLength: pillLoader.item ? (isVertical ? pillLoader.item.height : pillLoader.item.width) : 0
    readonly property real textLength: isVertical ? textLayout.implicitHeight : textLayout.implicitWidth

    property real targetLength: {
        if (module && !module.moduleActive) return 0;
        if (hideWhenZero && updateCount === 0) return 0;
        if (root.updatesStyle === "text") {
            return (textLength > 0) ? (textLength + s(root.isCompact ? (isVertical ? 4 : 5) : 6)) : 0;
        }
        return (pillLength > 0) ? (pillLength + s(root.isCompact ? 6 : 8)) : 0;
    }
    property bool isFaceVisible: showLayout && targetLength > 0

    function syncImplicitSize() {
        let cross = module ? module.thickness : (parent ? (isVertical ? parent.width : parent.height) : 0);
        implicitWidth = isVertical ? cross : targetLength;
        implicitHeight = isVertical ? targetLength : cross;
    }

    onTargetLengthChanged: syncImplicitSize()
    onIsVerticalChanged: syncImplicitSize()
    onModuleChanged: syncImplicitSize()
    onParentChanged: syncImplicitSize()

    Timer {
        running: true
        interval: 0
        onTriggered: root.syncImplicitSize()
    }

    Timer {
        running: !root.isPreview && (!module || module.moduleActive) && barWindow && barWindow.isStartupReady && barWindow.isDataReady
        interval: 100
        onTriggered: root.showLayout = true
    }

    transform: Translate {
        x: (root.isVertical || root.showLayout) ? 0 : s(60)
        Behavior on x { NumberAnimation { duration: 800; easing.type: Easing.OutQuint } }
    }

    MouseArea {
        id: textMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        enabled: root.updatesStyle === "text" && !root.isPreview
        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                UpdatesState.checkNow();
            } else {
                UpdatesState.launchUpdater();
            }
        }
    }

    AxisFlow {
        id: textLayout
        vertical: root.isVertical
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter
        visible: root.updatesStyle === "text"
        anchors.centerIn: parent
        spacing: s(root.isVertical ? 1 : 2)
        opacity: root.showLayout ? 1.0 : 0.0
        Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }

        Item {
            visible: root.showIcon
            width: root.isVertical ? arrowIcon.implicitWidth : s(root.isCompact ? 16 : 18)
            height: root.isVertical ? s(root.isCompact ? 14 : 16) : width

            Text {
                id: arrowIcon
                anchors.centerIn: parent
                text: "󰁝"
                font.family: ThemeBackend.iconFont
                font.pixelSize: root.isVertical ? s(root.isCompact ? 13 : 15) : s(root.isCompact ? 16 : 18)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: textMouseArea.containsMouse ? Qt.lighter(ThemeBackend.peach, 1.20) : (root.updateCount > 0 ? ThemeBackend.peach : ThemeBackend.subtext0)
                Behavior on color { ColorAnimation { duration: 150 } }
            }
        }

        Text {
            id: countText
            text: root.updateCountStr
            font.family: ThemeBackend.fontFamily
            font.pixelSize: s(root.isCompact ? 9 : 10)
            font.bold: true
            color: textMouseArea.containsMouse ? Qt.lighter(ThemeBackend.text, 1.15) : ThemeBackend.text
            Behavior on color { ColorAnimation { duration: 150 } }
        }
    }

    Loader {
        id: pillLoader
        visible: root.updatesStyle !== "text"
        anchors.centerIn: parent
        sourceComponent: root.isVertical ? sideButtonComponent : topButtonComponent
    }

    Component {
        id: topButtonComponent

        ClickButton {
            id: updatesPill
            property bool initAnimTrigger: root.isPreview
            height: s(root.lockLook ? 36 : (root.isCompact ? 28 : 30))
            maxWidth: s(root.isCompact ? 96 : 100)
            cornerRadius: root.lockLook ? ThemeBackend.borderRadius : Math.max(0, ThemeBackend.borderRadius - s(2))
            horizontalPadding: s(root.isCompact ? 10 : 12)
            buttonIcon: root.showIcon ? "󰁝" : ""
            iconFontSize: s(root.isCompact ? 14 : 15)
            buttonText: root.updateCountStr
            textFontSize: s(root.isCompact ? 11 : 12)
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            accentColor: root.lockLook ? Qt.lighter(ThemeBackend.surface0, 1.28) : (root.isCompact ? Qt.lighter(ThemeBackend.surface0, 1.18) : ThemeBackend.surface0)
            textColor: isHoveredOrHighlighted ? ThemeBackend.text : (root.isCompact ? Qt.lighter(ThemeBackend.text, 1.05) : ThemeBackend.text)

            property real targetWidth: Math.max(s(root.isCompact ? (root.showIcon ? 48 : 32) : (root.showIcon ? 52 : 36)), implicitWidth)
            width: targetWidth

            Behavior on width {
                enabled: barWindow && barWindow.startupCascadeFinished
                NumberAnimation { duration: 480; easing.type: Easing.OutQuint }
            }

            Timer { running: !root.isPreview && (!module || module.moduleActive) && root.showLayout && !updatesPill.initAnimTrigger; interval: 70; onTriggered: updatesPill.initAnimTrigger = true }
            opacity: initAnimTrigger ? 1.0 : 0.0
            transform: Translate { y: updatesPill.initAnimTrigger ? 0 : s(15); Behavior on y { NumberAnimation { duration: 620; easing.type: Easing.OutQuint } } }
            Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }

            onClicked: UpdatesState.launchUpdater()
            onRightClicked: UpdatesState.checkNow()
        }
    }

    Component {
        id: sideButtonComponent

        ClickButton {
            width: s(root.isCompact ? 28 : 30)
            height: s(root.isCompact ? 28 : 30)
            cornerRadius: Math.max(0, ThemeBackend.borderRadius - s(2))
            horizontalPadding: 0
            buttonIcon: root.showIcon ? "󰁝" : ""
            buttonText: root.updateCountStr
            textFontSize: s(root.isCompact ? 11 : 12)
            accentColor: root.lockLook ? Qt.lighter(ThemeBackend.surface0, 1.28) : (root.isCompact ? Qt.lighter(ThemeBackend.surface0, 1.18) : ThemeBackend.surface0)
            textColor: isHoveredOrHighlighted ? ThemeBackend.text : (root.isCompact ? Qt.lighter(ThemeBackend.text, 1.05) : ThemeBackend.text)

            onClicked: UpdatesState.launchUpdater()
            onRightClicked: UpdatesState.checkNow()
        }
    }
}
