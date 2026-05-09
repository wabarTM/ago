EAPI=8

inherit cmake toolchain-funcs git-r3

DESCRIPTION="xdg-desktop-portal backend for Hyprland"
HOMEPAGE="https://github.com/hyprwm/xdg-desktop-portal-hyprland"
EGIT_REPO_URI="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
LICENSE="MIT"
SLOT="0"
IUSE="elogind systemd"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	>=dev-cpp/sdbus-c++-2.0.0
	dev-libs/hyprlang:=
	dev-libs/inih
	dev-libs/wayland
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtwayland:6
	gui-libs/hyprutils:=
	media-libs/mesa
	>=media-video/pipewire-1.2.0:=
	x11-libs/libdrm
	|| (
		sys-libs/basu
		elogind? ( >=sys-auth/elogind-237 )
		systemd? ( >=sys-apps/systemd-237 )
	)
"

RDEPEND="
	${DEPEND}
	sys-apps/xdg-desktop-portal
"

BDEPEND="
	dev-libs/hyprland-protocols
	>=dev-libs/wayland-protocols-1.24
	>=dev-util/hyprwayland-scanner-0.4.2
	virtual/pkgconfig
	|| ( >=sys-devel/gcc-14:* >=llvm-core/clang-17:* )
"

src_prepare() {
	sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}
