import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

Item {
    id: popupRoot

    Layout.minimumWidth:   Kirigami.Units.gridUnit * 16
    Layout.minimumHeight:  Kirigami.Units.gridUnit * 12
    Layout.preferredWidth:  Plasmoid.configuration.popupWidth
    Layout.preferredHeight: Plasmoid.configuration.popupHeight

    function tempColor(t) {
        return t > 85 ? Kirigami.Theme.negativeTextColor
             : t > 70 ? Kirigami.Theme.neutralTextColor
             :           Kirigami.Theme.textColor
    }

    function tempStr(celsius) {
        if (celsius <= 0) return "—"
        if (Plasmoid.configuration.tempUnit === "F")
            return Math.round(celsius * 9 / 5 + 32) + " °F"
        return celsius + " °C"
    }

    ColumnLayout {
        anchors { fill: parent; margins: Kirigami.Units.largeSpacing }
        spacing: Kirigami.Units.largeSpacing

        // CPU usage
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            RowLayout {
                Layout.fillWidth: true
                PC3.Label { text: "CPU Usage"; font.bold: true }
                Item { Layout.fillWidth: true }
                PC3.Label {
                    text: root.cpuPercent + "%"
                    color: root.cpuPercent > 80 ? Kirigami.Theme.negativeTextColor : Kirigami.Theme.textColor
                    font.bold: root.cpuPercent > 80
                }
            }
            PC3.ProgressBar { Layout.fillWidth: true; value: root.cpuPercent / 100 }
        }

        // CPU temp (always visible)
        RowLayout {
            Layout.fillWidth: true
            PC3.Label { text: "CPU Temp"; font.bold: true }
            Item { Layout.fillWidth: true }
            PC3.Label { text: tempStr(root.cpuTemp); color: tempColor(root.cpuTemp) }
        }

        // GPU temp
        RowLayout {
            Layout.fillWidth: true
            visible: Plasmoid.configuration.showGpuTemp
            PC3.Label { text: "GPU Temp"; font.bold: true }
            Item { Layout.fillWidth: true }
            PC3.Label { text: tempStr(root.gpuTemp); color: tempColor(root.gpuTemp) }
        }

        // NVMe temp
        RowLayout {
            Layout.fillWidth: true
            visible: Plasmoid.configuration.showNvmeTemp
            PC3.Label { text: "NVMe Temp"; font.bold: true }
            Item { Layout.fillWidth: true }
            PC3.Label { text: tempStr(root.nvmeTemp); color: tempColor(root.nvmeTemp) }
        }

        // RAM
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            RowLayout {
                Layout.fillWidth: true
                PC3.Label { text: "Memory"; font.bold: true }
                Item { Layout.fillWidth: true }
                PC3.Label {
                    text: root.memUsedStr + " / " + root.memTotalStr + " GB  (" + root.memPercent + "%)"
                    color: root.memPercent > 80 ? Kirigami.Theme.negativeTextColor : Kirigami.Theme.textColor
                    font.bold: root.memPercent > 80
                }
            }
            PC3.ProgressBar { Layout.fillWidth: true; value: root.memPercent / 100 }
        }

        // Swap
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            visible: Plasmoid.configuration.showSwap && root.swapAvailable
            RowLayout {
                Layout.fillWidth: true
                PC3.Label { text: "Swap"; font.bold: true }
                Item { Layout.fillWidth: true }
                PC3.Label {
                    text: root.swapUsedStr + " / " + root.swapTotalStr + " GB  (" + root.swapPercent + "%)"
                    color: root.swapPercent > 80 ? Kirigami.Theme.negativeTextColor : Kirigami.Theme.textColor
                    font.bold: root.swapPercent > 80
                }
            }
            PC3.ProgressBar { Layout.fillWidth: true; value: root.swapPercent / 100 }
        }

        // Network
        RowLayout {
            Layout.fillWidth: true
            visible: Plasmoid.configuration.showNetwork
            PC3.Label { text: "Network"; font.bold: true }
            Item { Layout.fillWidth: true }
            PC3.Label { text: "↓ " + root.netDownStr + "/s   ↑ " + root.netUpStr + "/s" }
        }

        Item { Layout.fillHeight: true }

        PC3.Label {
            Layout.alignment: Qt.AlignRight
            text: "Updates every 2 s"
            font.pixelSize: Kirigami.Units.gridUnit * 0.65
            color: Kirigami.Theme.disabledTextColor
        }
    }

    // Resize grip
    MouseArea {
        id: resizeGrip
        width: 20; height: 20
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        cursorShape: Qt.SizeFDiagCursor
        hoverEnabled: true

        property real startGX: 0
        property real startGY: 0
        property int  startW:  0
        property int  startH:  0

        onPressed: (e) => {
            const g = mapToGlobal(e.x, e.y)
            startGX = g.x; startGY = g.y
            startW = popupRoot.width; startH = popupRoot.height
        }
        onPositionChanged: (e) => {
            if (!pressed) return
            const g = mapToGlobal(e.x, e.y)
            const minW = Kirigami.Units.gridUnit * 16
            const minH = Kirigami.Units.gridUnit * 12
            Plasmoid.configuration.popupWidth  = Math.max(minW, startW + g.x - startGX)
            Plasmoid.configuration.popupHeight = Math.max(minH, startH + g.y - startGY)
        }

        // Three-dot diagonal indicator
        Repeater {
            model: 3
            Rectangle {
                required property int index
                width: 2; height: 2; radius: 1
                color: Kirigami.Theme.textColor
                opacity: resizeGrip.containsMouse ? 0.6 : 0.25
                x: resizeGrip.width  - 4 - index * 5
                y: resizeGrip.height - 4 - index * 5
            }
        }
    }
}
