EAPI=8
inherit cmake git-r3

DESCRIPTION="Hyprland utilities library used across the ecosystem"
HOMEPAGE="https://github.com/hyprwm/hyprutils"
EGIT_REPO_URI="https://github.com/hyprwm/hyprutils.git"
EGIT_COMMIT="5ac060bfcf2f12b3a6381156ebbc13826a05b09f"
LICENSE="BSD"
SLOT="0"

RDEPEND="
	dev-cpp/gtest
"

DEPEND="${RDEPEND}"
