EAPI=8

inherit cmake git-r3

DESCRIPTION="Polkit authentication agent for Hyprland, written in Qt/QML"
HOMEPAGE="https://wiki.hypr.land/Hypr-Ecosystem/hyprpolkitagent/"
EGIT_REPO_URI="https://github.com/hyprwm/hyprpolkitagent.git"
LICENSE="BSD"
SLOT="0"

DEPEND="
	dev-qt/qtbase:6[gui,widgets]
	dev-qt/qtdeclarative:6
	gui-libs/hyprutils:=
	sys-auth/polkit
	sys-auth/polkit-qt[qt6]
"

RDEPEND="
	${DEPEND}
	gui-libs/hyprland-qt-support
"

BDEPEND="
	virtual/pkgconfig
"
