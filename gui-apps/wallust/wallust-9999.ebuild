EAPI=8

CRATES=" "
RUST_MIN_VER="1.88.0"

inherit git-r3 cargo

DESCRIPTION="Generate a 16 color scheme based on an image."
HOMEPAGE="https://explosion-mental.codeberg.page/wallust"
EGIT_REPO_URI="https://codeberg.org/explosion-mental/wallust.git"
SLOT="0"

QA_FLAGS_IGNORED=".*"
QA_PRESTRIPPED=".*"

ECARGO_VENDOR="${WORKDIR}/vendor"

pkg_setup() {
	#llvm-r2_pkg_setup
	rust_pkg_setup
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	#sed -i 's/git = "[^ ]*"/version = "*"/' Cargo.toml || die
	default
}

src_configure() {
	cargo_src_configure # --no-default-features
}

src_compile() {
	cargo_src_compile
}

src_install() {
	cargo_src_install

	#dobin resources/niri-session

	#insinto /usr/share/wayland-sessions
	#doins resources/niri.desktop

	#insinto /usr/share/xdg-desktop-portal
	#doins resources/niri-portals.conf
}

