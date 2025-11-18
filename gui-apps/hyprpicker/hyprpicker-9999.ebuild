EAPI=8
inherit cmake git-r3

DESCRIPTION="A wlroots-compatible Wayland color picker that does not suck"
HOMEPAGE="https://github.com/hyprwm/hyprpicker"
EGIT_REPO_URI="https://github.com/hyprwm/hyprpicker.git"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-libs/wayland
	>=dev-util/hyprwayland-scanner-0.4.2
	gui-libs/hyprutils:=
	x11-libs/cairo
	x11-libs/libxkbcommon
	x11-libs/pango
"
DEPEND="${RDEPEND}"

BDEPEND="
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
	media-libs/libglvnd
	media-libs/libjpeg-turbo
"
