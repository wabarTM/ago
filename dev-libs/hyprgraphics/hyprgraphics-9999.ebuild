EAPI=8
inherit git-r3 cmake

DESCRIPTION="Hyprland graphics / resource utilities"
HOMEPAGE="https://github.com/hyprwm/hyprgraphics"
EGIT_REPO_URI="https://github.com/hyprwm/hyprgraphics.git"
LICENSE="GPL-3"
SLOT="0"

# Upstream states that the simpleWindow test is broken, see bug 936653
RESTRICT="test"
RDEPEND="
	media-libs/libjxl
	media-libs/libspng
"
DEPEND="${RDEPEND}"

src_prepare() {
	# sed -i "/add_compile_options(-O3)/d" "${S}/CMakeLists.txt" || die
	cmake_src_prepare
}
