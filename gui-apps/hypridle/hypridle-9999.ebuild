EAPI=8

inherit cmake git-r3

DESCRIPTION="Hyprland's idle daemon"
HOMEPAGE="https://github.com/hyprwm/hypridle"
EGIT_REPO_URI="https://github.com/hyprwm/hypridle.git"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-cpp/sdbus-c++:0/2
	>=dev-libs/hyprlang-0.4.0
	dev-libs/wayland
	gui-libs/hyprutils:=
"
DEPEND="
	${RDEPEND}
	>=dev-libs/hyprland-protocols-0.6.0
	dev-libs/wayland-protocols
"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "CMakeLists.txt" || die
	cmake_src_prepare
}
