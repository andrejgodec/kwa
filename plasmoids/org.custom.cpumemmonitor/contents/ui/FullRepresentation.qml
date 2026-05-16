import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3
import org.kde.kirigami as Kirigami

Item {
    Layout.minimumWidth:    Kirigami.Units.gridUnit * 16
    Layout.minimumHeight:   Kirigami.Units.gridUnit * 8
    Layout.preferredWidth:  Kirigami.Units.gridUnit * 18
    Layout.preferredHeight: Kirigami.Units.gridUnit * 10

    ColumnLayout {
        anchors {
            fill: parent
            margins: Kirigami.Units.largeSpacing
        }
        spacing: Kirigami.Units.largeSpacing

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
            PC3.ProgressBar {
                Layout.fillWidth: true
                value: root.cpuPercent / 100
            }
        }

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
            PC3.ProgressBar {
                Layout.fillWidth: true
                value: root.memPercent / 100
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
