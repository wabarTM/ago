EAPI=8
inherit cmake toolchain-funcs git-r3

DESCRIPTION="Official implementation library for the hypr config language"
HOMEPAGE="https://github.com/hyprwm/hyprlang"
EGIT_REPO_URI="https://github.com/hyprwm/hyprlang.git"

LICENSE="LGPL-3"
SLOT="0"

RDEPEND=">=gui-libs/hyprutils-0.7.1:="
DEPEND="${RDEPEND}"
BDEPEND="|| ( >=sys-devel/gcc-15:* >=llvm-core/clang-19:* )"

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	tc-check-min_ver gcc 15
	tc-check-min_ver clang 19
}

