# KWA — KDE Widgets & Applets

Custom KDE Plasma 6 plasmoids for Fedora.

---

## CPU & RAM Monitor

A lightweight panel widget that shows live CPU and memory usage. Click it to expand a popup with progress bars.

### Preview

**Panel (compact view)**
```
CPU 23% | RAM 61%
```

**Popup (full view)**
- CPU Usage ████████░░ 78%
- Memory — 9.2 / 15.6 GB (59%)
- Updates every 2 seconds

Colors adapt: green → yellow above 50% → red above 80%.

### Requirements

- KDE Plasma 6
- Fedora (or any distro with `plasma-workspace`)

### Install

```bash
git clone https://github.com/yourusername/kwa.git
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
├── metadata.json          # Plasmoid ID and metadata
└── contents/ui/
    ├── main.qml                   # Data engine — reads /proc/stat and /proc/meminfo
    ├── CompactRepresentation.qml  # Panel view
    └── FullRepresentation.qml     # Popup view
```

### How it works

- Reads `/proc/stat` to calculate CPU delta between 2-second intervals
- Reads `/proc/meminfo` for total and available memory
- No external dependencies — pure QML + KDE frameworks
