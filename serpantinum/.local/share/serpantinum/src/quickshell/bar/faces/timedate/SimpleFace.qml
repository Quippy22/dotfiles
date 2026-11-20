import QtQuick
import QtQuick.Layouts
import "../../../reusables"
import "../../../"

Item {
    id: simpleFaceRoot
    property var widget: null

    readonly property bool isVertical: widget ? widget.orientation === "vertical" : false

    readonly property string fullTimeStr: {
        if (typeof DateTime !== "undefined" && DateTime.timeLong !== undefined && DateTime.timeLong !== null && String(DateTime.timeLong) !== "") {
            return String(DateTime.timeLong);
        }
        if (widget && widget.timeStr !== undefined && widget.timeStr !== null && String(widget.timeStr).split(":").length >= 3) {
            return String(widget.timeStr).replace(/\s*(am|pm|a\.m\.|p\.m\.)\s*$/i, "").trim();
        }
        var h = (widget && widget.hourStr !== undefined && String(widget.hourStr) !== "")
            ? String(widget.hourStr)
            : (typeof DateTime !== "undefined" && DateTime.hour ? String(DateTime.hour) : "14");
        var m = (widget && widget.minuteStr !== undefined && String(widget.minuteStr) !== "")
            ? String(widget.minuteStr)
            : (typeof DateTime !== "undefined" && DateTime.minute ? String(DateTime.minute) : "28");
        var sec = (widget && widget.secondStr !== undefined && String(widget.secondStr) !== "")
            ? String(widget.secondStr)
            : (typeof DateTime !== "undefined" && DateTime.second ? String(DateTime.second) : "00");
        return h + ":" + m + ":" + sec;
    }

    readonly property var parsedTime: {
        var parts = fullTimeStr.trim().split(":");
        return {
            hours: parts.length > 0 && parts[0] !== "" ? parts[0] : "14",
            minutes: parts.length > 1 && parts[1] !== "" ? parts[1] : "28",
            seconds: parts.length > 2 && parts[2] !== "" ? parts[2] : "00"
        };
    }

    readonly property color clockColor: (widget && widget.isCompact)
        ? Qt.lighter(ThemeBackend.blue, 1.1)
        : ThemeBackend.blue

    implicitWidth: bodyLoader.item ? bodyLoader.item.implicitWidth : 0
    implicitHeight: bodyLoader.item ? bodyLoader.item.implicitHeight : 0

    Loader {
        id: bodyLoader
        anchors.centerIn: parent
        sourceComponent: simpleFaceRoot.isVertical ? sideBodyComponent : topBodyComponent
    }

    Component {
        id: topBodyComponent

        Text {
            id: timeText
            text: simpleFaceRoot.fullTimeStr
            font.family: ThemeBackend.fontFamily
            font.pixelSize: widget ? widget.s(widget.isCompact ? 22 : 25) : 22
            font.weight: Font.Black
            color: simpleFaceRoot.clockColor
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }

    Component {
        id: sideBodyComponent

        Column {
            id: sideTimeCol
            spacing: widget ? widget.s(1) : 1

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: simpleFaceRoot.parsedTime.hours
                font.family: ThemeBackend.fontFamily
                font.pixelSize: widget ? widget.s(widget.isCompact ? 14 : 16) : 15
                font.weight: Font.Black
                color: simpleFaceRoot.clockColor
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: simpleFaceRoot.parsedTime.minutes
                font.family: ThemeBackend.fontFamily
                font.pixelSize: widget ? widget.s(widget.isCompact ? 14 : 16) : 15
                font.weight: Font.Black
                color: simpleFaceRoot.clockColor
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: simpleFaceRoot.parsedTime.seconds
                font.family: ThemeBackend.fontFamily
                font.pixelSize: widget ? widget.s(widget.isCompact ? 13 : 14) : 13
                font.weight: Font.Black
                color: simpleFaceRoot.clockColor
            }
        }
    }
}
