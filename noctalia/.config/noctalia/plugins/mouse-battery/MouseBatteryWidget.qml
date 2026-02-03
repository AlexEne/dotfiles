import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Widgets
import qs.Services.UI

Rectangle {
    id: root

    property var pluginApi: null
    property ShellScreen screen
    property string widgetId: ""
    property string section: ""

    // Per-screen bar properties
    readonly property string screenName: screen?.name ?? ""
    readonly property string barPosition: Settings.getBarPositionForScreen(screenName)
    readonly property bool isBarVertical: barPosition === "left" || barPosition === "right"
    readonly property real capsuleHeight: Style.getCapsuleHeightForScreen(screenName)
    readonly property real barFontSize: Style.getBarFontSizeForScreen(screenName)

    // Battery state
    property int batteryPercentage: 0
    property bool isCharging: false
    property string mouseName: "Mouse"
    property bool hasError: false

    // Update interval from settings (default 900 seconds = 15 minutes)
    readonly property int updateInterval: 900

    // Battery icons for different levels
    readonly property var batteryIcons: [
        "battery",        // 0-10%
        "battery-1",      // 11-20%
        "battery-1",      // 21-30%
        "battery-2",      // 31-40%
        "battery-2",      // 41-50%
        "battery-3",      // 51-60%
        "battery-3",      // 61-70%
        "battery-4",      // 71-80%
        "battery-4",      // 81-90%
        "battery-charging" // 91-100%
    ]

    readonly property string currentIcon: {
        if (hasError) return "battery-off"
        if (isCharging) return "battery-charging"
        var index = Math.min(batteryIcons.length - 1, Math.floor(batteryPercentage / 10))
        return batteryIcons[index]
    }

    implicitWidth: row.implicitWidth + Style.marginM * 2
    implicitHeight: capsuleHeight

    color: mouseArea.containsMouse ? Color.mHover : Style.capsuleColor
    radius: Style.radiusL
    border.color: Style.capsuleBorderColor
    border.width: Style.capsuleBorderWidth

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: Style.marginS

        NIcon {
            icon: root.currentIcon
            color: {
                if (mouseArea.containsMouse) return "black"
                if (root.hasError) return Color.mError
                if (root.isCharging) return Color.mPrimary
                if (root.batteryPercentage <= 10) return Color.mError
                if (root.batteryPercentage <= 20) return Color.mWarning
                return Color.mOnSurface
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            // Refresh battery status on click
            updateBatteryStatus()
        }

        onEntered: {
            var tooltipText = hasError 
                ? "Battery status unavailable"
                : mouseName + ": " + batteryPercentage + "%" + (isCharging ? " (Charging)" : "")
            TooltipService.show(root, tooltipText, BarService.getTooltipDirection())
        }

        onExited: {
            TooltipService.hide()
        }
    }

    // Timer to update battery status periodically
    Timer {
        id: updateTimer
        interval: root.updateInterval * 1000
        running: true
        repeat: true
        onTriggered: updateBatteryStatus()
    }

    // Process to get battery info
    Process {
        id: batteryProcess
        command: ["python3", Qt.resolvedUrl("solaar_battery.py").toString().replace("file://", "")]
        stdout: SplitParser {
            id: batteryStdout
            onRead: data => {
                try {
                    var result = JSON.parse(data)
                    if (result.error) {
                        Logger.e("MouseBattery", "Solaar error:", result.error)
                        root.hasError = true
                    } else {
                        root.batteryPercentage = result.percentage || 0
                        root.isCharging = result.charging || false
                        root.mouseName = result.name || "Mouse"
                        root.hasError = false
                    }
                } catch (e) {
                    Logger.e("MouseBattery", "Failed to parse battery data:", e)
                    root.hasError = true
                }
            }
        }
        stderr: SplitParser {
            onRead: data => {
                Logger.e("MouseBattery", "stderr:", data)
            }
        }
        onExited: (code, status) => {
            if (code !== 0) {
                Logger.e("MouseBattery", "Process exited with code:", code)
                root.hasError = true
            }
        }
    }

    // Update battery status on component load
    Component.onCompleted: {
        updateBatteryStatus()
    }

    function updateBatteryStatus() {
        batteryProcess.running = false
        batteryProcess.running = true
    }
}
