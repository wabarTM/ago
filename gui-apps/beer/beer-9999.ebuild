EAPI=8

CRATES=""
RUST_MIN_VER="1.98.0"

inherit git-r3 cargo

HOMEPAGE="https://git.notashelf.dev/notashelf/beer"
DESCRIPTION="Rafware beer"
EGIT_REPO_URI="https://git.notashelf.dev/notashelf/beer.git"

KEYWORDS="~amd64"
SLOT="0"
REQUIRED_USE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

pkg_setup() {
        rust_pkg_setup
}

src_unpack() {
        git-r3_src_unpack
        cd "${S}" || die
        cargo_live_src_unpack
}

src_prepare() {
        # sed -i 's/git = "[^ ]*"/version = "*"/' Cargo.toml || die
        default
}

src_configure() {
        # local myfeatures=()
        cargo_src_configure # --no-default-features
}

src_compile() {
        cargo_src_compile
}

src_install() {
        cargo_src_install --path ./crates/beer

        # dobashcomp "$(cargo_target_dir)"/../generated/completions/bash
        # dozshcomp "$(cargo_target_dir)"/../generated/completions/zsh
}

# pkg_postinst() {}
