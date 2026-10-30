#!/usr/bin/env bash
set -e

# ==========================================================
# Quick Extract - Uninstaller Skrip
# Menghapus instalasi dari direktori user
# ==========================================================

echo "=========================================="
echo "  Menghapus Quick Extract..."
echo "=========================================="

PREFIX_BIN="$HOME/.local/bin"
PREFIX_APP="$HOME/.local/share/applications"
PREFIX_KIO="$HOME/.local/share/kio/servicemenus"
PREFIX_K6="$HOME/.local/share/kservices6/ServiceMenus"
PREFIX_K5="$HOME/.local/share/kservices5/ServiceMenus"
PREFIX_NAUTILUS="$HOME/.local/share/nautilus/scripts"
PREFIX_NEMO="$HOME/.local/share/nemo/scripts"

rm -f "$PREFIX_BIN/quick-extract"
rm -f "$PREFIX_APP/quick-extract.desktop"
rm -f "$PREFIX_KIO/quick-extract.desktop"
rm -f "$PREFIX_K6/quick-extract.desktop"
rm -f "$PREFIX_K5/quick-extract.desktop"

rm -f "$PREFIX_NAUTILUS/Ekstrak di Sini" "$PREFIX_NAUTILUS/Ekstrak ke Folder Baru" "$PREFIX_NAUTILUS/Ekstrak ke..."
rm -f "$PREFIX_NEMO/Ekstrak di Sini" "$PREFIX_NEMO/Ekstrak ke Folder Baru" "$PREFIX_NEMO/Ekstrak ke..."

if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "$PREFIX_APP" >/dev/null 2>&1 || true
fi

if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
fi

echo "Quick Extract berhasil dihapus."
