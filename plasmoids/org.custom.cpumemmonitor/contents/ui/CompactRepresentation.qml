import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PC3
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

Item {
    Layout.fillHeight: true
    Layout.preferredWidth: row.implicitWidth + Kirigami.Units.smallSpacing * 2

    RowLayout {
        id: row
        anchors.centerIn: parent
        spacing: Kirigami.Units.smallSpacing

        Column {
            spacing: 1
            PC3.Label {
                text: "CPU"
                font.pixelSize: Kirigami.Units.gridUnit * 0.6
                color: Kirigami.Theme.disabledTextColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PC3.Label {
                text: root.cpuPercent + "%"
                font.pixelSize: Kirigami.Units.gridUnit * 0.75
                font.bold: true
                color: root.cpuPercent > 80
                    ? Kirigami.Theme.negativeTextColor
                    : root.cpuPercent > 50
                        ? Kirigami.Theme.neutralTextColor
                        : Kirigami.Theme.textColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            width: 1
            height: Kirigami.Units.gridUnit
            color: Kirigami.Theme.disabledTextColor
            opacity: 0.4
        }

        Column {
            spacing: 1
            PC3.Label {
                text: "RAM"
                font.pixelSize: Kirigami.Units.gridUnit * 0.6
                color: Kirigami.Theme.disabledTextColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PC3.Label {
                text: root.memPercent + "%"
                font.pixelSize: Kirigami.Units.gridUnit * 0.75
                font.bold: true
                color: root.memPercent > 80
                    ? Kirigami.Theme.negativeTextColor
                    : root.memPercent > 50
                        ? Kirigami.Theme.neutralTextColor
                        : Kirigami.Theme.textColor
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: Plasmoid.expanded = !Plasmoid.expanded
    }
}
