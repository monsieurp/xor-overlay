# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/electrified/${PN}.git"
else
	EGIT_COMMIT="d3b68dbd00b8d94f37d3b7a396e2b835266bd025"
	SRC_URI="https://github.com/electrified/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${PN}-${EGIT_COMMIT}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${EGIT_COMMIT}"
fi

DESCRIPTION="ASUS WMI Sensor driver"
HOMEPAGE="https://github.com/electrified/asus-wmi-sensors"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

CONFIG_CHECK="ACPI_WMI HWMON"
MODULE_NAMES="asus-wmi-sensors(misc:${S})"
BUILD_TARGETS="modules"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="TARGET=${KV_FULL} KERNEL_BUILD=${KERNEL_DIR} KBUILD_VERBOSE=1"
}

src_install() {
	linux-mod_src_install

	echo "${PN}" > "${T}/${PN}".conf || die
	insinto /usr/lib/modules-load.d/
	doins "${T}/${PN}".conf
	einstalldocs
}
