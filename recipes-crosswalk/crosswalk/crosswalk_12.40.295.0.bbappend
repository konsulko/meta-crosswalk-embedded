FILESEXTRAPATHS_prepend := "${THISDIR}/crosswalk:"

SRC_URI += " \
    file://build_fix.patch \
    ${@base_contains('DISTRO_FEATURES', 'systemd', 'file://disable-udev-log.patch', '', d)} \
    file://do_not_force_glib.patch \
    file://fix-jpeg-bool-boolean.patch \
    file://fix-missing-stat-includes.patch \
    file://fix-strict-overflow-error-bignum.patch \
    file://fix-strict-overflow-error-image.patch \
    file://wayland-egl-fix.patch \
    file://xwalk \
    "

DEPENDS_remove = "gtk+"
DEPENDS_remove = "libxss"
DEPENDS += "virtual/egl"

DEFAULT_CONFIGURATION += "\
    -Dozone_platform_gbm=0 \
    -Dozone_platform_wayland=1 \
    -Duse_ozone=1 \
    -Duse_udev=1 \
    "

do_install_append() {
    # Remove the symlink and replace with the wrapper
    rm -f ${D}${bindir}/xwalk

    install -d ${D}${bindir}/
    install -m 0755 ${WORKDIR}/xwalk ${D}${bindir}/xwalk
}
