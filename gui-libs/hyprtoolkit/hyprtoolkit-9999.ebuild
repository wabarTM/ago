EAPI=8
inherit cmake git-r3 toolchain-funcs

DESCRIPTION="A modern C++ Wayland-native GUI toolkit"
HOMEPAGE="https://github.com/hyprwm/hyprtoolkit"
EGIT_REPO_URI="https://github.com/hyprwm/hyprtoolkit.git"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	gui-libs/aquamarine
	gui-libs/hyprutils
	dev-libs/hyprlang
	dev-libs/hyprgraphics
	dev-util/hyprwayland-scanner
	dev-libs/iniparser
	dev-cpp/gtest
"

DEPEND="${RDEPEND}"

pkg_setup() {
	tc-check-min_ver gcc 15
	tc-check-min_ver clang 19
}
