# Maintainer: tamsy
pkgname=quick-extract
pkgver=1.0.0
pkgrel=1
pkgdesc="Ekstraktor file arsip ringan dengan integrasi klik-kanan file manager (Dolphin, Nautilus, Nemo, Thunar)"
arch=('any')
url="https://github.com/Zeeynrs/Quick-Extract"
license=('GPL3')
depends=('python' 'libarchive' 'libnotify')
optdepends=(
    'kdialog: Dialog pemilihan folder native Qt di KDE Dolphin'
    'zenity: Dialog pemilihan folder GTK'
    '7zip: Dukungan arsip 7z & RAR proprietary'
    'unrar: Dukungan arsip RAR proprietary'
)
source=()

package() {
    cd "${srcdir}/.."
    install -Dm755 bin/quick-extract "${pkgdir}/usr/bin/quick-extract"
    install -Dm644 desktop/quick-extract.desktop "${pkgdir}/usr/share/applications/quick-extract.desktop"
    install -Dm644 desktop/quick-extract-servicemenu.desktop "${pkgdir}/usr/share/kio/servicemenus/quick-extract.desktop"
    
    # Scripts untuk Nautilus & Nemo
    install -Dm755 scripts/nautilus/Ekstrak\ di\ Sini "${pkgdir}/usr/share/nautilus-scripts/Ekstrak di Sini"
    install -Dm755 scripts/nautilus/Ekstrak\ ke\ Folder\ Baru "${pkgdir}/usr/share/nautilus-scripts/Ekstrak ke Folder Baru"
    install -Dm755 scripts/nautilus/Ekstrak\ ke... "${pkgdir}/usr/share/nautilus-scripts/Ekstrak ke..."
}
