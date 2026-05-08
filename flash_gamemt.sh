#!/bin/bash
# Flash script for GameMT E6 / YX13-GAME-V3.1
# Place this file in your home directory (~/)
# Image folder should be at ~/Image_hendheld_e6_gamemt/

TOOL="$HOME/Image_hendheld_e6_gamemt/upgrade_tool"
IMG="$HOME/Image_hendheld_e6_gamemt"

# Check if upgrade_tool exists
if [ ! -f "$TOOL" ]; then
    echo "ERROR: upgrade_tool not found at $TOOL"
    echo "Please place upgrade_tool in ~/Image_hendheld_e6_gamemt/"
    exit 1
fi

chmod +x "$TOOL"

# Language selection
echo "1. Polski"
echo "2. English"
read -p "Wybierz jezyk / Choose language (1/2): " lang

if [ "$lang" = "1" ]; then
    MSG_TITLE="=== Skrypt Flashowania GameMT E6 ==="
    MSG_CHECK="Sprawdzam połączenie z konsolą..."
    MSG_ASK="Konsola widoczna w trybie Maskrom? (t/n): "
    MSG_NO="Podłącz konsolę w trybie Maskrom i uruchom ponownie!"
    MSG_ERASE_ASK="Wyczyścić całą pamięć przed wgraniem? (usuwa dane użytkownika!) (t/n): "
    MSG_ERASING="Czyszczenie pamięci..."
    MSG_DONE="=== GOTOWE! Możesz odłączyć USB i uruchomić konsolę ==="
    MSG_ERR="BŁĄD podczas wgrywania:"
    ANS_YES="t"
else
    MSG_TITLE="=== GameMT E6 Flash Script ==="
    MSG_CHECK="Checking console connection..."
    MSG_ASK="Console visible in Maskrom mode? (y/n): "
    MSG_NO="Connect console in Maskrom mode and run again!"
    MSG_ERASE_ASK="Erase all memory before flashing? (deletes user data!) (y/n): "
    MSG_ERASING="Erasing memory..."
    MSG_DONE="=== DONE! You can disconnect USB and start the console ==="
    MSG_ERR="ERROR during flashing:"
    ANS_YES="y"
fi

echo "$MSG_TITLE"
echo "$MSG_CHECK"
$TOOL LD 2>&1 | grep -i "rockusb\|DevNo"

read -p "$MSG_ASK" odp
if [ "$odp" != "$ANS_YES" ]; then
    echo "$MSG_NO"
    exit 1
fi

read -p "$MSG_ERASE_ASK" erase
if [ "$erase" = "$ANS_YES" ]; then
    echo "$MSG_ERASING"
    $TOOL EF "$IMG/MiniLoaderAll.bin" 2>&1
    sleep 3
    $TOOL DB "$IMG/MiniLoaderAll.bin" 2>&1
    sleep 2
fi

flash() {
    local name=$1
    local cmd=$2
    echo ""
    echo ">>> $name"
    eval "$cmd"
    if [ $? -ne 0 ]; then
        echo "$MSG_ERR $name"
    fi
}

flash "Loader (DB)"   "$TOOL DB $IMG/MiniLoaderAll.bin"
flash "uboot"         "$TOOL DI -u $IMG/uboot.img"
flash "trust"         "$TOOL DI -t $IMG/trust.img"
flash "misc"          "$TOOL DI -m $IMG/misc.img"
flash "resource"      "$TOOL DI -re $IMG/resource_new.img"
flash "kernel"        "$TOOL DI -k $IMG/kernel.img"
flash "boot"          "$TOOL DI -b $IMG/boot.img"
flash "recovery"      "$TOOL DI -r $IMG/recovery.img"
flash "system"        "$TOOL DI -s $IMG/system_new.img"
flash "vendor"        "$TOOL WL 0x00454000 $IMG/vendor_new.img"
flash "oem"           "$TOOL WL 0x00514000 $IMG/oem_new.img"
flash "logo"          "$TOOL WL 0x00654000 $IMG/boot_logo_yx13.bmp"

echo ""
echo "$MSG_DONE"
