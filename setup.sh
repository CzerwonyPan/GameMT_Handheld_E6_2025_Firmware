#!/bin/bash
# Setup script for GameMT E6 flashing tools
# Tested on Ubuntu 20.04, 22.04, 24.04 and derivatives (Zorin, Mint, Pop!_OS)

set -e

echo "╔══════════════════════════════════════════╗"
echo "║   GameMT E6 - Setup narzędzi / Tools     ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# Detect OS
if ! command -v apt-get &> /dev/null; then
    echo "ERROR: This script requires apt-get (Ubuntu/Debian based system)"
    exit 1
fi

echo "[1/5] Aktualizacja listy pakietów / Updating package list..."
sudo apt-get update -q

echo "[2/5] Instalacja zależności / Installing dependencies..."
sudo apt-get install -y \
    android-tools-adb \
    android-sdk-libsparse-utils \
    libusb-1.0-0 \
    usbutils \
    python3 \
    python3-pil \
    wget \
    unzip

echo "[3/5] Konfiguracja reguł udev dla Rockchip / Setting up udev rules..."
cat << 'UDEV' | sudo tee /etc/udev/rules.d/99-rockchip.rules > /dev/null
# Rockchip devices - Maskrom and Loader mode
SUBSYSTEM=="usb", ATTR{idVendor}=="2207", MODE="0666", GROUP="plugdev"
UDEV

sudo udevadm control --reload-rules
sudo udevadm trigger

echo "[4/5] Dodawanie użytkownika do grupy plugdev / Adding user to plugdev group..."
sudo usermod -aG plugdev "$USER"

echo "[5/5] Sprawdzanie upgrade_tool / Checking upgrade_tool..."
TOOL="$HOME/Image_hendheld_e6_gamemt/upgrade_tool"
if [ -f "$TOOL" ]; then
    chmod +x "$TOOL"
    echo "    ✓ upgrade_tool znaleziony / found"
else
    echo ""
    echo "    ⚠ upgrade_tool NIE ZNALEZIONY / NOT FOUND"
    echo ""
    echo "    Pobierz / Download upgrade_tool:"
    echo "    1. Wejdź na / Go to: https://github.com/rockchip-linux/rkbin"
    echo "       lub / or search: 'Rockchip upgrade_tool Linux'"
    echo "    2. Pobierz plik 'upgrade_tool' dla Linuxa"
    echo "    3. Umieść go w / Place it in:"
    echo "       ~/Image_hendheld_e6_gamemt/upgrade_tool"
    echo ""
    echo "    Alternatywnie możesz użyć rkdeveloptool:"
    echo "    sudo apt-get install rkdeveloptool"
fi

# Copy flash script to home
if [ -f "$(dirname "$0")/flash_gamemt.sh" ]; then
    cp "$(dirname "$0")/flash_gamemt.sh" "$HOME/"
    chmod +x "$HOME/flash_gamemt.sh"
    echo "    ✓ flash_gamemt.sh skopiowany do ~/"
fi

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║              GOTOWE / DONE               ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "WAŻNE / IMPORTANT:"
echo "Wyloguj się i zaloguj ponownie aby zastosować"
echo "zmiany grup / Log out and back in to apply"
echo "group changes (plugdev)."
echo ""
echo "Następny krok / Next step:"
echo "  bash ~/flash_gamemt.sh"
