import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3
import org.kde.kirigami as Kirigami

Item {
    Layout.minimumWidth:    Kirigami.Units.gridUnit * 16
    Layout.minimumHeight:   Kirigami.Units.gridUnit * 20
    Layout.preferredWidth:  Kirigami.Units.gridUnit * 22
    Layout.preferredHeight: Kirigami.Units.gridUnit * 26

    function tempColor(t) {
        return t > 85 ? Kirigami.Theme.negativeTextColor
             : t > 70 ? Kirigami.Theme.neutralTextColor
             :           Kirigami.Theme.textColor
    }

    function tempStr(t) {
        return t > 0 ? t + " °C" : "—"
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

        // CPU temp
        RowLayout {
            Layout.fillWidth: true
            PC3.Label { text: "CPU Temp"; font.bold: true }
            Item { Layout.fillWidth: true }
            PC3.Label { text: tempStr(root.cpuTemp); color: tempColor(root.cpuTemp) }
        }

        // GPU temp
        RowLayout {
            Layout.fillWidth: true
            PC3.Label { text: "GPU Temp"; font.bold: true }
            Item { Layout.fillWidth: true }
            PC3.Label { text: tempStr(root.gpuTemp); color: tempColor(root.gpuTemp) }
        }

        // NVMe temp
        RowLayout {
            Layout.fillWidth: true
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
            visible: root.swapAvailable
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
}
