EAPI=8
inherit cmake git-r3 toolchain-funcs

DESCRIPTION="Hyprland GUI utilities (successor to hyprland-qtutils)"
HOMEPAGE="https://github.com/hyprwm/hyprland-guiutils"
EGIT_REPO_URI="https://github.com/hyprwm/hyprland-guiutils"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	gui-libs/hyprtoolkit
	gui-libs/hyprutils:=
	gui-libs/hyprland-qt-support
"

DEPEND="${RDEPEND}"

pkg_setup() {
	tc-check-min_ver gcc 15
	tc-check-min_ver clang 19
}
