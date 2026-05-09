EAPI=8

inherit git-r3 cmake

DESCRIPTION="The hyprland cursor format, library and utilities"
HOMEPAGE="https://github.com/hyprwm/hyprcursor"
EGIT_REPO_URI="https://github.com/hyprwm/hyprcursor.git"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-cpp/tomlplusplus
	>=dev-libs/hyprlang-0.4.2
	dev-libs/libzip
	gnome-base/librsvg:2
	x11-libs/cairo
"
