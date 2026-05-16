import QtQuick
import org.kde.plasma.plasmoid
import org.kde.ksysguard.sensors as Sensors

PlasmoidItem {
    id: root

    property real cpuPercent: Math.round(cpuSensor.value ?? 0)
    property real memPercent: memTotalSensor.value > 0
        ? Math.round(memUsedSensor.value / memTotalSensor.value * 100)
        : 0
    property string memUsedStr: (memUsedSensor.value / 1073741824).toFixed(1)
    property string memTotalStr: (memTotalSensor.value / 1073741824).toFixed(1)

    Sensors.Sensor {
        id: cpuSensor
        sensorId: "cpu/all/usage"
        updateRateLimit: 2000
    }

    Sensors.Sensor {
        id: memUsedSensor
        sensorId: "memory/physical/used"
        updateRateLimit: 2000
    }

    Sensors.Sensor {
        id: memTotalSensor
        sensorId: "memory/physical/total"
        updateRateLimit: 2000
    }

    compactRepresentation: CompactRepresentation { }
    fullRepresentation: FullRepresentation { }
}
