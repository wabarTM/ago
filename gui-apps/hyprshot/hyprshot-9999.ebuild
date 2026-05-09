EAPI=8

inherit git-r3 #optfeature

DESCRIPTION="Utility to easily take screenshots in Hyprland using your mouse"
HOMEPAGE="https://github.com/Gustash/Hyprshot/"
EGIT_REPO_URI="https://github.com/Gustash/Hyprshot.git"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	app-misc/jq
	gui-apps/grim
	gui-apps/slurp
	gui-apps/wl-clipboard
	gui-wm/hyprland
	x11-libs/libnotify
"

src_install() {
	dobin hyprshot
	einstalldocs
}
