# KWA — KDE Widgets & Applets

Custom KDE Plasma 6 plasmoids for Fedora.

---

## CPU & RAM Monitor

A lightweight panel widget showing live CPU and memory usage. Click to expand a popup with detailed stats.

### Preview

**Panel (compact view)**
```
CPU 23% | RAM 61%
```

**Popup (full view)**
- CPU Usage ████████░░ 78%
- CPU Temp 83 °C / 181 °F
- GPU Temp 77 °C
- NVMe Temp 62 °C
- Memory — 9.2 / 15.6 GB (59%)
- Swap — 0.0 / 8.0 GB (0%)
- Network ↓ 1.2 MB/s   ↑ 120 KB/s
- Updates every 2 seconds

Colors adapt: neutral → yellow above 70 °C / red above 85 °C for temps; yellow above 80% / red for usage.

### Configuration

Right-click the widget → **Configure CPU & RAM Monitor**:

| Setting | Options | Default |
|---------|---------|---------|
| Temperature unit | Celsius (°C) / Fahrenheit (°F) | °C |
| Show GPU temperature | on / off | on |
| Show NVMe temperature | on / off | on |
| Show Swap | on / off | on |
| Show Network | on / off | on |

The popup is resizable — drag the grip in the bottom-right corner. Size is saved across sessions.

### Requirements

- KDE Plasma 6
- Fedora (or any distro with `plasma-workspace` and `lm_sensors`)

### Install

```bash
git clone https://github.com/andrejgodec/kwa.git
cd kwa
ln -sf "$PWD/plasmoids/org.custom.cpumemmonitor" \
       ~/.local/share/plasma/plasmoids/org.custom.cpumemmonitor
kquitapp6 plasmashell; sleep 2; plasmashell --replace &
```

Then: **Right-click panel → Add Widgets → search "CPU & RAM Monitor" → drag to panel.**

### Uninstall

```bash
rm ~/.local/share/plasma/plasmoids/org.custom.cpumemmonitor
kquitapp6 plasmashell; sleep 2; plasmashell --replace &
```

### File Structure

```
plasmoids/org.custom.cpumemmonitor/
├── metadata.json
└── contents/
    ├── config/
    │   ├── main.xml           # KConfigXT schema (settings keys + defaults)
    │   └── config.qml         # Registers config pages
    └── ui/
        ├── main.qml                   # Sensors + data properties (ksystemstats)
        ├── CompactRepresentation.qml  # Panel view
        ├── FullRepresentation.qml     # Popup view
        └── ConfigGeneral.qml          # Settings page
```

### How it works

Uses `org.kde.ksysguard.sensors` to subscribe to live ksystemstats data:

| Metric | Sensor ID |
|--------|-----------|
| CPU usage | `cpu/all/usage` |
| CPU temp | `cpu/all/averageTemperature` |
| GPU temp | `gpu/gpu1/temperature` |
| NVMe temp | `lmsensors/nvme-pci-0200/temp1` |
| RAM used/total | `memory/physical/used` / `memory/physical/total` |
| Swap used/total | `memory/swap/used` / `memory/swap/total` |
| Network | `network/all/download` / `network/all/upload` |
