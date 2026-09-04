EAPI=8

inherit meson git-r3

DESCRIPTION="xdg-desktop-portal backend for choosing files with your favorite file chooser"
HOMEPAGE="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser"
EGIT_REPO_URI="https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-apps/xdg-desktop-portal
	dev-libs/inih
	|| (
		sys-auth/elogind
		sys-apps/systemd
		sys-libs/basu
	)
"

RDEPEND="
	${DEPEND}
"

BDEPEND="app-text/scdoc"

src_install() {
	dodoc Compatibility.md

	meson_src_install

	rm -r "${ED}/usr/share/${PN}/systemd" || die
}

