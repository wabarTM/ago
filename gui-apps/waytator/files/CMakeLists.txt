cmake_minimum_required(VERSION 3.20)

project(waytator
    VERSION 1.1.1
    LANGUAGES C
)

include(GNUInstallDirs)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

find_package(PkgConfig REQUIRED)

pkg_check_modules(GTK4 REQUIRED IMPORTED_TARGET gtk4>=4.10)
pkg_check_modules(ADWAITA REQUIRED IMPORTED_TARGET libadwaita-1>=1.6)

find_program(GLIB_COMPILE_RESOURCES glib-compile-resources REQUIRED)
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
    ${GRESOURCE_C}
)

target_include_directories(waytator PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_BINARY_DIR}/generated
)

target_link_libraries(waytator PRIVATE
    PkgConfig::GTK4
    PkgConfig::ADWAITA
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
