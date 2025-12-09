EAPI=8
inherit git-r3 cmake

DESCRIPTION="Wayland protocol extensions for Hyprland"
HOMEPAGE="https://github.com/hyprwm/hyprland-protocols"


EGIT_REPO_URI="https://github.com/hyprwm/${PN}.git"
LICENSE="BSD"
SLOT="0"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}
