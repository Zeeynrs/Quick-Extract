# Quick Extract

A fast, lightweight archive extraction utility for Linux with native right-click context menu integration for popular file managers including **KDE Dolphin**, **GNOME Nautilus**, **Cinnamon Nemo**, and **Thunar**.

Similar to built-in archive extraction utilities (such as Ark, File Roller, or 7-Zip context menus), Quick Extract lets you decompress archives directly from your file manager's context menu without opening terminal windows or bulky GUI applications.

---

## ✨ Features

- **Context Menu Integration**:
  - 📂 **Extract Here**: Extracts archive contents into the current directory.
  - 📁 **Extract to Subfolder**: Automatically creates and extracts into a dedicated folder named after the archive (e.g. `project.tar.gz` extracts into `project/`).
  - 🗂️ **Extract to...**: Opens a native folder picker dialog (`kdialog` for KDE / `zenity` for GTK) to choose any destination directory.
- **Wide Format Support**:
  - Archive containers: `.zip`, `.cbz`, `.jar`, `.apk`
  - Tarballs: `.tar`, `.tar.gz`, `.tgz`, `.tar.bz2`, `.tbz`, `.tbz2`, `.tar.xz`, `.txz`, `.tar.zst`
  - Other formats: `.7z`, `.rar`, `.cbr`, `.iso`, `.cpio`, `.deb`, `.rpm`
  - Single-file compression: `.gz`, `.bz2`, `.xz`, `.zst`, `.lzma`
- **Fast & Secure Engine**:
  - Powered by `bsdtar` (`libarchive`) for high-performance, non-blocking extraction.
  - Pure Python fallback for zip and tar archives when external tools are unavailable.
  - Built-in Zip Slip / path traversal protection.
  - Desktop notifications via `notify-send`.
- **Multi-File Batch Extraction**:
  - Select multiple archives at once in your file manager and extract all of them simultaneously.

---

## 🚀 Installation

### 1. User-level Installation (Recommended - No root/sudo required)

Clone the repository and run the installer script:

```bash
git clone https://github.com/Zeeynrs/Quick-Extract.git
cd Quick-Extract
./install.sh
```

The script automatically:
1. Copies the executable to `~/.local/bin/quick-extract`.
2. Registers KDE Dolphin ServiceMenus in `~/.local/share/kio/servicemenus/`.
3. Registers standard desktop entries in `~/.local/share/applications/`.
4. Registers Nautilus & Nemo scripts in `~/.local/share/nautilus/scripts/`.
5. Updates desktop and MIME caches.

> **Tip**: If Dolphin or your file manager is currently open, close and reopen it to reload the new context menus.

### 2. Arch Linux Package (`makepkg`)

To install system-wide via pacman:

```bash
cd Quick-Extract
makepkg -si
```

---

## 🗑️ Uninstallation

To remove Quick Extract and its desktop integrations, run:

```bash
cd Quick-Extract
./uninstall.sh
```

---

## 💻 CLI Usage (Optional)

In addition to file manager context menus, `quick-extract` can also be used directly from your shell:

```bash
# Extract into current directory
quick-extract --here archive.zip

# Extract into a subfolder
quick-extract --subfolder project.tar.gz

# Open a GUI directory picker
quick-extract --dialog backup.7z

# Extract to a specified path
quick-extract --to /path/to/destination files.rar
```

---

## 📦 Dependencies

- **Python** (>= 3.8)
- **libarchive** (provides `bsdtar`, pre-installed on most Linux distributions)
- **libnotify** (`notify-send`, for desktop notifications)

### Optional Dependencies
- `kdialog`: Native Qt folder picker dialog in KDE Dolphin.
- `zenity`: Native GTK folder picker dialog in GNOME / XFCE.
- `7zip` / `unrar`: For proprietary RAR or specialized 7z archives.

---

## 📄 License

This project is licensed under the [GNU General Public License v3.0](LICENSE).
