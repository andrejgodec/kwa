import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3
import org.kde.kirigami as Kirigami

Item {
    Layout.minimumWidth:    Kirigami.Units.gridUnit * 16
    Layout.minimumHeight:   Kirigami.Units.gridUnit * 18
    Layout.preferredWidth:  Kirigami.Units.gridUnit * 20
    Layout.preferredHeight: Kirigami.Units.gridUnit * 22

    ColumnLayout {
        anchors {
            fill: parent
            margins: Kirigami.Units.largeSpacing
        }
        spacing: Kirigami.Units.largeSpacing

        // CPU
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

        // CPU Temperature
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            visible: root.cpuTemp > 0
            RowLayout {
                Layout.fillWidth: true
                PC3.Label { text: "CPU Temp"; font.bold: true }
                Item { Layout.fillWidth: true }
                PC3.Label {
                    text: root.cpuTemp + " °C"
                    color: root.cpuTemp > 85 ? Kirigami.Theme.negativeTextColor
                         : root.cpuTemp > 70 ? Kirigami.Theme.neutralTextColor
                         :                      Kirigami.Theme.textColor
                    font.bold: root.cpuTemp > 85
                }
            }
            PC3.ProgressBar { Layout.fillWidth: true; value: Math.min(root.cpuTemp / 100, 1.0) }
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
        ColumnLayout {
            Layout.fillWidth: true
            spacing: Kirigami.Units.smallSpacing
            RowLayout {
                Layout.fillWidth: true
                PC3.Label { text: "Network"; font.bold: true }
                Item { Layout.fillWidth: true }
                PC3.Label {
                    text: "↓ " + root.netDownStr + "/s   ↑ " + root.netUpStr + "/s"
                    color: Kirigami.Theme.textColor
                }
            }
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
