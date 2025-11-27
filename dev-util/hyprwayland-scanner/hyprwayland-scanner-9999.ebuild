EAPI=8
inherit git-r3 cmake

DESCRIPTION="A Hyprland implementation of wayland-scanner, in and for C++."
HOMEPAGE="https://github.com/hyprwm/hyprwayland-scanner"
EGIT_REPO_URI="https://github.com/hyprwm/hyprwayland-scanner.git"
LICENSE="BSD"
SLOT="0"

RDEPEND=">=dev-libs/pugixml-1.14"

DEPEND="${RDEPEND}"

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return
}
