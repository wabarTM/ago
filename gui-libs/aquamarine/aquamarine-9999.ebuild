EAPI=8

inherit cmake git-r3

DESCRIPTION="Aquamarine is a very light linux rendering backend library"
HOMEPAGE="https://github.com/hyprwm/aquamarine"
EGIT_REPO_URI="https://github.com/hyprwm/aquamarine.git"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	>=dev-libs/libinput-1.26.1
	dev-libs/wayland
	>=dev-util/hyprwayland-scanner-0.4.5
	>=gui-libs/hyprutils-0.8.4:=
	media-libs/libdisplay-info:=
	media-libs/libglvnd
	media-libs/mesa[opengl]
	sys-apps/hwdata
	>=sys-auth/seatd-0.8.0
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	virtual/libudev
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}
