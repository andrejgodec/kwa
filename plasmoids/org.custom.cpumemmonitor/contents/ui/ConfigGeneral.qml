import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    property string cfg_tempUnit
    property int    cfg_refreshRate
    property alias cfg_showGpuTemp:  showGpuTemp.checked
    property alias cfg_showNvmeTemp: showNvmeTemp.checked
    property alias cfg_showSwap:     showSwap.checked
    property alias cfg_showNetwork:  showNetwork.checked

    readonly property var refreshRates: [1000, 2000, 5000, 10000]
    readonly property var refreshLabels: ["1 s", "2 s", "5 s", "10 s"]

    QQC2.ComboBox {
        Kirigami.FormData.label: "Refresh rate:"
        model: refreshLabels
        currentIndex: refreshRates.indexOf(cfg_refreshRate) >= 0
                      ? refreshRates.indexOf(cfg_refreshRate) : 1
        onCurrentIndexChanged: cfg_refreshRate = refreshRates[currentIndex]
    }

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
