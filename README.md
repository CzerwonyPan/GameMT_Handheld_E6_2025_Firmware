# GameMT E6 Handheld 2025 (YX13-GAME-V3.1) - Niestandardowy firmware

[![Licencja](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## 🚀 O projekcie
Ten firmware zastępuje oryginalne oprogramowanie konsoli **GameMT E6 2025**, usuwając złośliwe aplikacje (gameMante, F-Droid), dodając **root** i możliwość instalacji emulatorów (RetroArch, PPSSPP). Działa na płycie **YX13-GAME-V3.1** z procesorem **Rockchip RK3326 (Android 8.1)**.

## 📥 Pobieranie i instrukcja
**👉 [Pełna instrukcja flashowania z plikami](https://czerwonypan.github.io/GameMT_Handheld_E6_2025_Firmware/)**

## 📂 Zawartość repozytorium
*   `index.html` - interaktywna instrukcja krok po kroku
*   `flash_gamemt.sh` - automatyczny skrypt flashowania dla Linux
*   `setup.sh` - skrypt konfiguracyjny środowiska
*   `FactoryTool_v1.63.zip` - narzędzie flashowania dla Windows
*   `Rockchip_DriverAssitant_v5.1.1.zip` - sterowniki USB (Windows)
*   `Testpoints_maskrom.jpg` - zdjęcie płyty z testpointami

## 📖 Wymagania
*   Konsola GameMT E6 (model 2025, płyta V3.1)
*   Kabel USB (A na C/micro)
*   Komputer z Linux lub Windows
*   Podstawowe umiejętności otwierania obudowy

## 🛠 Szybki start (Linux)
```bash
git clone https://github.com/CzerwonyPan/GameMT_Handheld_E6_2025_Firmware.git
cd GameMT_Handheld_E6_2025_Firmware
chmod +x setup.sh flash_gamemt.sh
bash setup.sh  # instaluje zależności i reguły USB
# Po restarcie sesji wejdź w tryb Maskrom i uruchom:
bash flash_gamemt.sh
