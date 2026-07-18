EAPI=8

inherit cmake toolchain-funcs git-r3

DESCRIPTION="Wayland image annotation tool"
HOMEPAGE="https://github.com/faetalize/waytator"
EGIT_REPO_URI="https://github.com/faetalize/waytator"
SLOT="0"

RDEPEND="
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"

DEPEND="
	${RDEPEND}
"

BDEPEND="
	dev-build/cmake
	dev-build/ninja
	virtual/pkgconfig
"
src_prepare() {
	# cmake shenanigans
	sed -i 's/@WAYTATOR_VERSION@/"@PROJECT_VERSION@"/g' src/waytator-config.h.in

	# Consistencty, fml
	sed -i 's/WAYTATOR_APP_ID "dev.faetalize.waytator"/WAYTATOR_APP_ID "Waytator"/' src/main.c
	sed -i 's/dev.faetalize.waytator/waytator/g' src/dev.faetalize.waytator.desktop
	cp "${FILESDIR}"/CMakeLists.txt ./

	eapply_user
	default
	cmake_src_prepare
}
