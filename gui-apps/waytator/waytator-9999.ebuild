EAPI=8

inherit meson cmake toolchain-funcs git-r3

DESCRIPTION="Wayland image annotation tool"
HOMEPAGE="https://github.com/faetalize/waytator"
EGIT_REPO_URI="https://github.com/faetalize/waytator"
SLOT="0"

RDEPEND="
        gui-libs/gtk:4
        gui-libs/libadwaita:1
        gui-libs/gtk-layer-shell
        dev-libs/wayland
        media-video/ffmpeg
        media-libs/rubberband
        x11-libs/libdrm
        media-video/pipewire
        media-libs/gstreamer:1.0
"

DEPEND="
        ${RDEPEND}
"

BDEPEND="
        dev-build/ninja
        virtual/pkgconfig
        dev-libs/glib:2
        gui-libs/gtk:4
        dev-util/wayland-scanner
        dev-libs/wayland-protocols
"
src_prepare() {
#        # cmake shenanigans
#        sed -i 's/@WAYTATOR_VERSION@/"@PROJECT_VERSION@"/g' src/waytator-config.h.in
#        cp "${FILESDIR}"/CMakeLists.txt ./

        # Consistencty, fml
        sed -i 's/WAYTATOR_APP_ID "dev.faetalize.waytator"/WAYTATOR_APP_ID "Waytator"/' src/main.c
        sed -i 's/dev.faetalize.waytator/waytator/g' src/dev.faetalize.waytator.desktop



        sed -i '1i #include <glib-object.h>' src/main.c
        sed -i 's/gtk4-layer-shell/gtk-layer-shell/g' meson.build

        eapply_user
        default
}

src_configure() {
        meson_src_configure
}

src_compile() {
        meson_src_compile
}

src_install() {
        meson_src_install
}
