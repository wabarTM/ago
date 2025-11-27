EAPI=8
inherit git-r3

DESCRIPTION="Software for playing Microsoft Windows games and launchers"
HOMEPAGE="https://linux-gaming.ru/"
EGIT_REPO_URI="https://github.com/Castro-Fidel/PortProton_ALT.git"

KEYWORDS="~amd64"
LICENSE="MIT"
SLOT="0"

DEPEND="
		sys-apps/bubblewrap
		net-misc/wget
		app-arch/cabextract
		app-arch/tar
		dev-libs/openssl
		media-gfx/icoutils
		media-libs/mesa
		net-misc/curl
		sys-apps/inxi
		gnome-extra/zenity
		gnome-extra/yad
		sys-devel/bc
		x11-apps/xrandr"

RDEPEND="${DEPEND}"

src_install() {
		install -Dm775 "$WORKDIR/${P}/${PN}" "${D}/usr/bin/${PN}"
}
