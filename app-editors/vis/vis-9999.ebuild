EAPI=8

LUA_COMPAT=( lua5-{2..5} )

inherit lua-single git-r3
EGIT_REPO_URI="https://github.com/martanne/vis.git"
KEYWORDS="~amd64"

DESCRIPTION="Modern, legacy free, simple yet efficient vim-like editor"
HOMEPAGE="https://github.com/martanne/vis"
SLOT="0"
IUSE="+acl +lua +ncurses selinux test tre"
REQUIRED_USE="lua? ( ${LUA_REQUIRED_USE} )"
RESTRICT="!test? ( test )"

# - Known to also work with NetBSD curses
DEPEND="
        dev-libs/libtermkey
        acl? ( sys-apps/acl )
        lua? ( ${LUA_DEPS} )
        ncurses? ( sys-libs/ncurses:0= )
        selinux? ( sys-libs/libselinux )
        tre? ( dev-libs/tre )
"
RDEPEND="
        ${DEPEND}
        app-eselect/eselect-vi
        lua? (
                $(lua_gen_cond_dep 'dev-lua/lpeg[${LUA_USEDEP}]')
        )
"
# lpeg: https://github.com/martanne/vis-test/issues/28
BDEPEND="
        virtual/pkgconfig
        test? (
                $(lua_gen_cond_dep 'dev-lua/lpeg[${LUA_USEDEP}]')
                $(lua_gen_cond_dep 'dev-lua/busted[${LUA_USEDEP}]')
        )
"

pkg_setup() {
        use lua && lua-single_pkg_setup
}

src_prepare() {
        if use test; then
                if [ ! "${PV}" == "9999" ]; then
                        rm -r test || die
                        mv "${WORKDIR}/vis-test-${VIS_TEST_COMMIT}" test || die
                fi

                # https://github.com/martanne/vis-test/issues/27 a Werror clone
                sed -i 's;|| strstr(output, "warning");;' test/core/ccan-config.c || die
        fi

        sed -i 's|STRIP?=.*|STRIP=true|' Makefile || die
        sed -i 's|${DOCPREFIX}/vis|${DOCPREFIX}|' Makefile || die
        sed -i 's|DOCUMENTATION = LICENSE|DOCUMENTATION =|' Makefile || die

        default
}

src_configure() {
        local myconfargs=(
                --prefix="${EPREFIX}"/usr
                --docdir="${EPREFIX}"/usr/share/doc/${PF}
                --disable-lpeg-static
                $(use_enable acl)
                $(use_enable lua)
                $(use_enable ncurses curses)
                $(use_enable selinux)
                $(use_enable tre)
        )

        ./configure "${myconfargs[@]}" || die
}

update_symlinks() {
        einfo "Calling eselect vi update --if-unset"
        eselect vi update --if-unset
}

pkg_postrm() {
        update_symlinks
}

pkg_postinst() {
        update_symlinks
}
