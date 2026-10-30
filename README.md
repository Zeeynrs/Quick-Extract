# Quick Extract

**Quick Extract** adalah package ekstraktor file arsip ringan dan cepat untuk Linux dengan integrasi menu klik-kanan pada file manager (KDE Dolphin, GNOME Nautilus, Cinnamon Nemo, Thunar, dsb).

Mirip dengan utility ekstrak bawaan (seperti Ark, File Roller, atau 7-Zip context menu), Quick Extract memudahkan Anda mengekstrak arsip langsung dari klik kanan tanpa perlu membuka terminal atau aplikasi berat.

---

## ✨ Fitur Utama

- **Integrasi Menu Klik-Kanan (Context Menu)**:
  - 📂 **Ekstrak di Sini (Extract Here)**: Mengekstrak isi arsip langsung di direktori yang sama.
  - 📁 **Ekstrak ke Subfolder (Extract to Subfolder)**: Otomatis membuat subfolder dengan nama arsip (misal `project.tar.gz` diekstrak ke folder `project/`).
  - 🗂️ **Ekstrak ke... (Extract to...)**: Membuka dialog pemilih folder (`kdialog` untuk KDE / `zenity` untuk GTK) untuk menentukan folder tujuan secara leluasa.
- **Dukungan Format Luas**:
  - `.zip`, `.cbz`, `.jar`, `.apk`
  - `.tar`, `.tar.gz`, `.tgz`, `.tar.bz2`, `.tbz`, `.tbz2`, `.tar.xz`, `.txz`, `.tar.zst`
  - `.7z`, `.rar`, `.cbr`
  - `.iso`, `.cpio`, `.deb`, `.rpm`
  - Kompresi tunggal: `.gz`, `.bz2`, `.xz`, `.zst`, `.lzma`
- **Engine Cepat & Aman**:
  - Menggunakan `bsdtar` (`libarchive`) sebagai engine utama yang sangat cepat dan hemat resource.
  - Proteksi otomatis terhadap serangan Zip Slip / path traversal.
  - Dilengkapi notifikasi desktop (`notify-send`) yang ramah dan responsif.
- **Multi-File Support**:
  - Pilih beberapa arsip sekaligus di Dolphin/Nautilus, klik kanan -> ekstrak semuanya dalam satu klik.

---

## 🚀 Cara Instalasi

### 1. Instalasi Otomatis (Rekomendasi - Tanpa Root / Sudo)

Jalankan script installer:

```bash
cd ~/Projects/quick-extract
./install.sh
```

Installer akan otomatis:
1. Menyalin binary ke `~/.local/bin/quick-extract`.
2. Mendaftarkan ServiceMenu KDE Dolphin di `~/.local/share/kio/servicemenus/`.
3. Mendaftarkan Desktop Action di `~/.local/share/applications/`.
4. Mendaftarkan skrip untuk GNOME Nautilus & Nemo di `~/.local/share/nautilus/scripts/`.
5. Memperbarui cache database desktop.

> **Catatan**: Jika Dolphin sedang terbuka, tutup jendela Dolphin lalu buka kembali agar menu konteks klik-kanan langsung muncul.

### 2. Instalasi via Arch Linux Package (`makepkg`)

Jika Anda ingin menginstalnya secara global sebagai paket pacman:

```bash
cd ~/Projects/quick-extract
makepkg -si
```

---

## 🗑️ Cara Uninstall

Cukup jalankan script uninstaller:

```bash
cd ~/Projects/quick-extract
./uninstall.sh
```

---

## 💻 Penggunaan via Terminal (Opsional)

Selain dari klik-kanan file manager, `quick-extract` juga bisa dipanggil via terminal:

```bash
# Ekstrak di direktori saat ini
quick-extract --here berkas.zip

# Ekstrak ke subfolder otomatis
quick-extract --subfolder proyek.tar.gz

# Pilih folder tujuan via dialog GUI
quick-extract --dialog data.7z

# Ekstrak ke folder tertentu
quick-extract --to /home/user/Tujuan berkas.rar
```

---

## 📦 Ketergantungan (Dependencies)

- `python` (>= 3.8)
- `libarchive` (menyediakan `bsdtar`, sudah terinstal di Arch Linux)
- `libnotify` (`notify-send`, untuk notifikasi desktop)
- *Opsional*:
  - `kdialog` (untuk pemilih folder Qt di KDE Dolphin)
  - `zenity` (untuk pemilih folder GTK di Nautilus / GNOME)
  - `7zip` / `unrar` (untuk arsip 7z/RAR proprietary jika diperlukan)
