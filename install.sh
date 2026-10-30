#!/usr/bin/env bash
set -e

# ==========================================================
# Quick Extract - Installer Skrip untuk User
# Menginstal bin, desktop integration (Dolphin, Nautilus, Nemo)
# ==========================================================

echo "=========================================="
echo "  Menginstal Quick Extract..."
echo "=========================================="

PREFIX_BIN="$HOME/.local/bin"
PREFIX_APP="$HOME/.local/share/applications"
PREFIX_KIO="$HOME/.local/share/kio/servicemenus"
PREFIX_K6="$HOME/.local/share/kservices6/ServiceMenus"
PREFIX_K5="$HOME/.local/share/kservices5/ServiceMenus"
PREFIX_NAUTILUS="$HOME/.local/share/nautilus/scripts"
PREFIX_NEMO="$HOME/.local/share/nemo/scripts"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Pastikan direktori tujuan tersedia
mkdir -p "$PREFIX_BIN" "$PREFIX_APP" "$PREFIX_KIO" "$PREFIX_K6" "$PREFIX_K5" "$PREFIX_NAUTILUS" "$PREFIX_NEMO"

# 2. Salin executable utama
echo "[1/5] Menyalin executable ke $PREFIX_BIN..."
cp "$SCRIPT_DIR/bin/quick-extract" "$PREFIX_BIN/quick-extract"
chmod +x "$PREFIX_BIN/quick-extract"

# 3. Salin desktop file (Open With & Universal integration)
echo "[2/5] Mendaftarkan Desktop Entry ke $PREFIX_APP..."
cp "$SCRIPT_DIR/desktop/quick-extract.desktop" "$PREFIX_APP/quick-extract.desktop"

# 4. Salin ServiceMenu KDE Dolphin
echo "[3/5] Mendaftarkan menu klik-kanan KDE Dolphin ke $PREFIX_KIO..."
cp "$SCRIPT_DIR/desktop/quick-extract-servicemenu.desktop" "$PREFIX_KIO/quick-extract.desktop"
ln -sf "$PREFIX_KIO/quick-extract.desktop" "$PREFIX_K6/quick-extract.desktop" 2>/dev/null || true
ln -sf "$PREFIX_KIO/quick-extract.desktop" "$PREFIX_K5/quick-extract.desktop" 2>/dev/null || true

# 5. Salin script untuk Nautilus dan Nemo
echo "[4/5] Mendaftarkan script Nautilus & Nemo..."
cp "$SCRIPT_DIR"/scripts/nautilus/* "$PREFIX_NAUTILUS/" 2>/dev/null || true
chmod +x "$PREFIX_NAUTILUS"/* 2>/dev/null || true
cp "$SCRIPT_DIR"/scripts/nemo/* "$PREFIX_NEMO/" 2>/dev/null || true
chmod +x "$PREFIX_NEMO"/* 2>/dev/null || true

# 6. Perbarui database desktop & KDE
echo "[5/5] Memperbarui cache desktop & file manager..."
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$PREFIX_APP" >/dev/null 2>&1 || true
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo ""
echo "=========================================="
echo "  Instalasi Quick Extract Berhasil! 🎉"
echo "=========================================="
echo "Menu klik-kanan sekarang aktif di Dolphin / File Manager:"
echo "  • Ekstrak di Sini (Extract Here)"
echo "  • Ekstrak ke Subfolder (Extract to Subfolder)"
echo "  • Ekstrak ke... (Extract to...)"
echo ""
echo "Catatan:"
echo "Jika Dolphin sedang terbuka, tutup dan buka kembali untuk"
echo "memuat menu konteks klik-kanan yang baru."
