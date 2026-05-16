import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    property string cfg_tempUnit
    property alias cfg_showGpuTemp:  showGpuTemp.checked
    property alias cfg_showNvmeTemp: showNvmeTemp.checked
    property alias cfg_showSwap:     showSwap.checked
    property alias cfg_showNetwork:  showNetwork.checked

    QQC2.ComboBox {
        Kirigami.FormData.label: "Temperature unit:"
        model: ["Celsius (°C)", "Fahrenheit (°F)"]
        currentIndex: cfg_tempUnit === "F" ? 1 : 0
        onCurrentIndexChanged: cfg_tempUnit = currentIndex === 1 ? "F" : "C"
    }

    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: "Visible metrics"
    }

    QQC2.Switch { id: showGpuTemp;  Kirigami.FormData.label: "GPU temperature:" }
    QQC2.Switch { id: showNvmeTemp; Kirigami.FormData.label: "NVMe temperature:" }
    QQC2.Switch { id: showSwap;     Kirigami.FormData.label: "Swap:" }
    QQC2.Switch { id: showNetwork;  Kirigami.FormData.label: "Network:" }
}
