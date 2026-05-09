EAPI=8
inherit cmake toolchain-funcs git-r3

DESCRIPTION="A fast and consistent wire protocol for IPC"
HOMEPAGE="https://github.com/hyprwm/hyprwire"
EGIT_REPO_URI="https://github.com/hyprwm/hyprwire.git"
LICENSE="BSD"
SLOT="0"

# я хер его знает от чего оно зависит
RDEPEND=""
DEPEND="${RDEPEND}"
BDEPEND=""

pkg_setup() {
	tc-check-min_ver gcc 15
	tc-check-min_ver clang 19
}

src_prepare() {
	rm -rf tests/

	eapply "${FILESDIR}"/0000-remove-tests.patch

	eapply_user
	default
	cmake_src_prepare
}
