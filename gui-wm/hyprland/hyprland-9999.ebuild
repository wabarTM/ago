# this should be latest git version and i dont care about non-latest shenanigans

EAPI=8

inherit cmake toolchain-funcs git-r3

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland"
EGIT_REPO_URI="https://github.com/hyprwm/Hyprland.git"
#EGIT_COMMIT="920353370bba555010506a1c0b204675c60362fe" # first bad, maybe fixed later?
#EGIT_COMMIT="834f019bab5df85b912a7aab7054fc8306f7c52a"
#EGIT_COMMIT="3bbbb5aaca3a79005f7c2fea2b7bba66e9da5ce8"
#EGIT_COMMIT="09e195d1f293a876ce21a077af3d7c5047881b79"
LICENSE="BSD"
SLOT="0"
IUSE="X -guiutils systemd hyprpm xwmfix noengine"

RDEPEND="
	dev-cpp/muParser
	dev-cpp/tomlplusplus
	dev-libs/glib:2
	dev-libs/hyprlang
	dev-libs/libinput:=
	dev-libs/hyprgraphics:=
	dev-libs/re2:=
	dev-libs/udis86
	dev-libs/wayland
	gui-libs/aquamarine
	gui-libs/hyprcursor
	gui-libs/hyprutils
	media-libs/libglvnd
	media-libs/mesa
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	x11-libs/libXcursor
	guiutils? ( gui-libs/hyprland-guiutils )
	X? (
		x11-libs/libxcb
		x11-base/xwayland
		x11-libs/xcb-util-errors
		x11-libs/xcb-util-wm
	)
	hyprpm? (
		dev-build/cmake
		dev-vcs/git
		virtual/pkgconfig
	)
"

DEPEND="
	${RDEPEND}
	dev-cpp/glaze
	>=dev-libs/hyprland-protocols-0.6.0
	>=dev-libs/wayland-protocols-1.41
"
BDEPEND="
	|| ( >=sys-devel/gcc-15:* >=llvm-core/clang-19:* )
	app-misc/jq
	dev-build/cmake
	>=dev-util/hyprwayland-scanner-0.3.10
	virtual/pkgconfig
"

# i need those to not forget how to write shit
pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	tc-check-min_ver gcc 15
	tc-check-min_ver clang 19
}

src_prepare() {
	rm -rf start/

	eapply "${FILESDIR}"/0000-remove-start-hyprland.patch
	eapply "${FILESDIR}"/0001-no-watchdog.patch

	if use xwmfix; then
		eapply "${FILESDIR}"/0002-fix-xwayland.patch
	fi

	if use noengine; then
		printf "" > src/i18n/Engine.cpp
		eapply "${FILESDIR}"/0003-only-english-in-i18n.patch
	fi

	eapply_user
	default
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# i have 0 fucking clues how to fix mutlilib issue,
		# so i will just disable whole testing module
		-DBUILD_TESTING:BOOL=false

		#-DCMAKE_BUILD_TYPE:STRING=Debug

		-DNO_XWAYLAND:STRING=$(usex X false true)
		-DNO_SYSTEMD:STRING=$(usex systemd false true)
		-DNO_HYPRPM:STRING=$(usex hyprpm false true)
    )

	cmake_src_configure
}

src_compile() {
	cmake_src_compile
}

src_install() {
	cmake_src_install
}

