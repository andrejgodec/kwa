import QtQuick
import org.kde.plasma.plasmoid
import org.kde.ksysguard.sensors as Sensors

PlasmoidItem {
    id: root

    property real cpuPercent: Math.round(cpuSensor.value ?? 0)
    property real cpuTemp:    Math.round(cpuTempSensor.value ?? 0)
    property real gpuTemp:    Math.round(gpuTempSensor.value ?? 0)
    property real nvmeTemp:   Math.round(nvmeTempSensor.value ?? 0)

    property real memPercent: memTotalSensor.value > 0
        ? Math.round(memUsedSensor.value / memTotalSensor.value * 100) : 0
    property string memUsedStr:  (memUsedSensor.value  / 1073741824).toFixed(1)
    property string memTotalStr: (memTotalSensor.value / 1073741824).toFixed(1)

    property real swapPercent: swapTotalSensor.value > 0
        ? Math.round(swapUsedSensor.value / swapTotalSensor.value * 100) : 0
    property string swapUsedStr:  (swapUsedSensor.value  / 1073741824).toFixed(1)
    property string swapTotalStr: (swapTotalSensor.value / 1073741824).toFixed(1)
    property bool   swapAvailable: swapTotalSensor.value > 0

    property string netDownStr: formatNet(netDownSensor.value)
    property string netUpStr:   formatNet(netUpSensor.value)

    function formatNet(bytes) {
        const b = bytes ?? 0
        if (b >= 1048576) return (b / 1048576).toFixed(1) + " MB"
        if (b >= 1024)    return Math.round(b / 1024) + " KB"
        return Math.round(b) + " B"
    }

    function tempColor(t) {
        return t > 85 ? Kirigami.Theme.negativeTextColor
             : t > 70 ? Kirigami.Theme.neutralTextColor
             :           Kirigami.Theme.textColor
    }

    Sensors.Sensor { id: cpuSensor;      sensorId: "cpu/all/usage";                              updateRateLimit: 2000 }
    Sensors.Sensor { id: memUsedSensor;  sensorId: "memory/physical/used";                       updateRateLimit: 2000 }
    Sensors.Sensor { id: memTotalSensor; sensorId: "memory/physical/total";                      updateRateLimit: 2000 }
    Sensors.Sensor { id: swapUsedSensor; sensorId: "memory/swap/used";                           updateRateLimit: 2000 }
    Sensors.Sensor { id: swapTotalSensor;sensorId: "memory/swap/total";                          updateRateLimit: 2000 }
    Sensors.Sensor { id: netDownSensor;  sensorId: "network/all/download";                       updateRateLimit: 2000 }
    Sensors.Sensor { id: netUpSensor;    sensorId: "network/all/upload";                         updateRateLimit: 2000 }
    Sensors.Sensor { id: cpuTempSensor;  sensorId: "lmsensors/k10temp-pci-00c3/Tctl/value";     updateRateLimit: 2000 }
    Sensors.Sensor { id: gpuTempSensor;  sensorId: "lmsensors/amdgpu-pci-c300/edge/value";      updateRateLimit: 2000 }
    Sensors.Sensor { id: nvmeTempSensor; sensorId: "lmsensors/nvme-pci-0200/Composite/value";   updateRateLimit: 2000 }

    compactRepresentation: CompactRepresentation { }
    fullRepresentation:    FullRepresentation    { }
}
