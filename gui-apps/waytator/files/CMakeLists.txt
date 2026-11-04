cmake_minimum_required(VERSION 3.20)

project(waytator
    VERSION 1.5.1
    LANGUAGES C
)

include(GNUInstallDirs)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED)

pkg_check_modules(GTK4 REQUIRED IMPORTED_TARGET gtk4>=4.14)
pkg_check_modules(ADWAITA REQUIRED IMPORTED_TARGET libadwaita-1>=1.6)
pkg_check_modules(LAYER_SHELL REQUIRED IMPORTED_TARGET gtk-layer-shell-0)
pkg_check_modules(WAYLAND_CLIENT REQUIRED IMPORTED_TARGET wayland-client>=1.20)
pkg_check_modules(AVFORMAT REQUIRED IMPORTED_TARGET libavformat>=60)
pkg_check_modules(AVCODEC REQUIRED IMPORTED_TARGET libavcodec>=60)
pkg_check_modules(AVFILTER REQUIRED IMPORTED_TARGET libavfilter>=9)
pkg_check_modules(AVUTIL REQUIRED IMPORTED_TARGET libavutil>=58)
pkg_check_modules(SWSCALE REQUIRED IMPORTED_TARGET libswscale>=7)
pkg_check_modules(SWRESAMPLE REQUIRED IMPORTED_TARGET libswresample>=4.10)
pkg_check_modules(LIBDRM REQUIRED IMPORTED_TARGET libdrm)
pkg_check_modules(PIPEWIRE REQUIRED IMPORTED_TARGET libpipewire-0.3>=0.3.50)
pkg_check_modules(RUBBERBAND REQUIRED IMPORTED_TARGET rubberband>=3.0)
pkg_check_modules(GIO_UNIX REQUIRED IMPORTED_TARGET gio-unix-2.0)
pkg_check_modules(GBM REQUIRED IMPORTED_TARGET gbm)
pkg_check_modules(EGL REQUIRED IMPORTED_TARGET egl)

find_program(GLIB_COMPILE_RESOURCES glib-compile-resources REQUIRED)
find_program(WAYLAND_SCANNER wayland-scanner REQUIRED)
find_library(M_LIB m)

set(WAYTATOR_SOURCES
    src/main.c
    src/waytator-canvas-input.c
    src/waytator-canvas-layout.c
    src/waytator-canvas-render.c
    src/waytator-canvas-state.c
    src/waytator-document.c
    src/waytator-export.c
    src/waytator-ocr.c
    src/waytator-render.c
    src/waytator-stroke.c
    src/waytator-window.c
)

# Generate Wayland protocol sources
set(WAYLAND_PROTOCOL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/protocols")
file(GLOB WAYLAND_PROTOCOLS "${WAYLAND_PROTOCOL_DIR}/*.xml")

set(WAYLAND_GENERATED_SOURCES)
foreach(PROTOCOL ${WAYLAND_PROTOCOLS})
    get_filename_component(PROTO_NAME ${PROTOCOL} NAME_WE)
    set(PROTO_C "${CMAKE_CURRENT_BINARY_DIR}/generated/${PROTO_NAME}-protocol.c")
    set(PROTO_H "${CMAKE_CURRENT_BINARY_DIR}/generated/${PROTO_NAME}-client-protocol.h")
    
    add_custom_command(
        OUTPUT ${PROTO_C} ${PROTO_H}
        COMMAND ${WAYLAND_SCANNER} private-code < ${PROTOCOL} > ${PROTO_C}
        COMMAND ${WAYLAND_SCANNER} client-header < ${PROTOCOL} > ${PROTO_H}
        DEPENDS ${PROTOCOL}
    )
    list(APPEND WAYLAND_GENERATED_SOURCES ${PROTO_C})
endforeach()

configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/src/waytator-config.h.in
    ${CMAKE_CURRENT_BINARY_DIR}/generated/waytator-config.h
    @ONLY
)

set(GRESOURCE_XML ${CMAKE_CURRENT_SOURCE_DIR}/src/waytator.gresource.xml)
set(GRESOURCE_C   ${CMAKE_CURRENT_BINARY_DIR}/generated/waytator-resources.c)

add_custom_command(
    OUTPUT ${GRESOURCE_C}
    COMMAND ${GLIB_COMPILE_RESOURCES}
            --generate-source
            --target=${GRESOURCE_C}
            --sourcedir=${CMAKE_CURRENT_SOURCE_DIR}/src
            --c-name=waytator
            ${GRESOURCE_XML}
    DEPENDS
        ${GRESOURCE_XML}
        src/ui/window.ui
        src/ui/style.css
        src/ui/icons/blur-symbolic.svg
        src/ui/icons/crop-symbolic.svg
        src/ui/icons/eraser-symbolic.svg
        src/ui/icons/hand-openyay-symbolic.svg
        src/ui/icons/marker-symbolic.svg
        src/ui/icons/pencil-symbolic.svg
        src/ui/icons/rotate-symbolic.svg
        src/ui/icons/scanner-symbolic.svg
        src/ui/icons/shape-arrow-symbolic.svg
        src/ui/icons/shape-circle-symbolic.svg
        src/ui/icons/shape-line-symbolic.svg
        src/ui/icons/shape-square-symbolic.svg
        src/ui/icons/shapes-symbolic.svg
        src/ui/icons/text-insert2-symbolic.svg
        src/ui/icons/icon.png
        src/ui/icons/icon-256.png
        src/ui/icons/icon-512.png
        src/ui/icons/index.theme
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/src
    VERBATIM
)

add_executable(waytator
    ${WAYTATOR_SOURCES}
    ${WAYLAND_GENERATED_SOURCES}
    ${GRESOURCE_C}
)

target_include_directories(waytator PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_BINARY_DIR}/generated
)

target_link_libraries(waytator PRIVATE
    PkgConfig::GTK4
    PkgConfig::ADWAITA
    PkgConfig::LAYER_SHELL
    PkgConfig::WAYLAND_CLIENT
    PkgConfig::AVFORMAT
    PkgConfig::AVCODEC
    PkgConfig::AVFILTER
    PkgConfig::AVUTIL
    PkgConfig::SWSCALE
    PkgConfig::SWRESAMPLE
    PkgConfig::LIBDRM
    PkgConfig::PIPEWIRE
    PkgConfig::RUBBERBAND
    PkgConfig::GIO_UNIX
    PkgConfig::GBM
    PkgConfig::EGL
)

if(M_LIB)
    target_link_libraries(waytator PRIVATE ${M_LIB})
endif()

target_compile_options(waytator PRIVATE
    -Wall
    -Wextra
    -Wpedantic
)

install(TARGETS waytator
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(FILES src/dev.faetalize.waytator.desktop
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/applications
    RENAME waytator.desktop
)

install(FILES src/ui/icons/icon.png
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/128x128/apps
    RENAME waytator.png
)

install(FILES src/ui/icons/icon-256.png
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/256x256/apps
    RENAME waytator.png
)

install(FILES src/ui/icons/icon-512.png
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/icons/hicolor/512x512/apps
    RENAME waytator.png
)
