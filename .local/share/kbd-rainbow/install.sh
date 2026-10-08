#!/bin/bash
# Install kbd-rainbow as an isolated system service. Run with: sudo ./install.sh
set -euo pipefail

SRC=$(dirname "$(readlink -f "$0")")
DESKTOP_USER=${SUDO_USER:?run this with sudo from your normal account}

# Isolated system account: no login shell, no home directory
getent passwd kbdlight >/dev/null ||
    useradd --system --no-create-home --home-dir /nonexistent --shell /usr/sbin/nologin kbdlight

# Root-owned program, so nothing running as the desktop user can modify it
install -m 0755 -o root -g root "$SRC/kbd-rainbow" /usr/local/bin/kbd-rainbow

# Shared state dir: owned by kbdlight, writable by the desktop user's group for the wheel controls
install -d -o kbdlight -g "$DESKTOP_USER" -m 2775 /var/lib/kbd-rainbow

# Device access for kbdlight only (replaces the earlier rule that gave the desktop user access)
install -m 0644 -o root -g root "$SRC/70-bequiet-keyboard.rules" /etc/udev/rules.d/70-bequiet-keyboard.rules
udevadm control --reload
udevadm trigger --action=change --subsystem-match=hidraw --subsystem-match=input
udevadm settle

install -m 0644 -o root -g root "$SRC/kbd-rainbow.service" /etc/systemd/system/kbd-rainbow.service
systemctl daemon-reload
systemctl enable --now kbd-rainbow.service
systemctl restart kbd-rainbow.service

sleep 3
systemctl --no-pager status kbd-rainbow.service | head -12
journalctl -u kbd-rainbow.service -n 5 --no-pager
