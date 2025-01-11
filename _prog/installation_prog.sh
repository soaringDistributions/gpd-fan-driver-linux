
# ATTRIBUTION-AI: ChatGPT o1 2025-01-11 ... partially .
_setup_prog() {
    sudo -n apt-get update
    sudo -n apt-get install -y build-essential dkms git devscripts debhelper dpkg-dev
}


# ATTRIBUTION-AI: ChatGPT o1 2025-01-11 ... partially .
_build_prog_sequence() {
    _start

    cd "$safeTmp"
    #git clone git@github.com:Cryolitia/gpd-fan-driver.git
    cp -a "$scriptLib"/gpd-fan-driver "$safeTmp"/
    cd gpd-fan-driver
    mkdir src
    mv -f ./* src/

    mkdir -p "$safeTmp"/gpd-fan-driver/debian

    # https://en.wikipedia.org/wiki/Debian_version_history#Debian_12_(Bookworm)
    cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/gpd-fan-driver/debian/control
Source: gpd-fan-driver-dkms
Maintainer: Soaring Distributions LLC not_yet@example.com
Build-Depends: debhelper (>= 9), dkms
Homepage: https://github.com/Cryolitia/gpd-fan-driver
Vcs-Git: git@github.com:Cryolitia/gpd-fan-driver.git
Vcs-Browser: https://github.com/Cryolitia/gpd-fan-driver

Package: gpd-fan-driver-dkms
Architecture: all
Priority: optional
Section: kernel
Depends: dkms (>= 1.95), linux-headers-686-pae | linux-headers-amd64 | linux-headers-generic | linux-headers, ${misc:Depends}
Description: GPD Fan driver for GPD Win Mini 2024 (8840U)
 This package provides a DKMS-based kernel module for the GPD Win Mini's fan.
 It defers compilation until the moment you install this package (via DKMS).
CZXWXcRMTo8EmM8i4d

    # https://en.wikipedia.org/wiki/Debian_version_history#Debian_12_(Bookworm)
    cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/gpd-fan-driver/debian/compat
10
CZXWXcRMTo8EmM8i4d

# https://github.com/soaringDistributions/gasket-driver/blob/4568a135dc7ac893a99972d03f7c86a4ab7ffb9a/debian/rules
    cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/gpd-fan-driver/debian/rules
#!/usr/bin/make -f

include /usr/share/dpkg/pkg-info.mk

# We build a "source only" DKMS package by overriding
# most build/clean steps so that compilation is deferred.

%:
	dh $@ --with dkms

override_dh_install:
	dh_install src/* usr/src/gpd-fan-driver-$(DEB_VERSION_UPSTREAM)/

override_dh_dkms:
	# Pass upstream version to DKMS so it knows how to name the source tree.
	dh_dkms -V $(DEB_VERSION_UPSTREAM)

override_dh_auto_configure:
override_dh_auto_build:
override_dh_auto_test:
override_dh_auto_install:
override_dh_auto_clean:
CZXWXcRMTo8EmM8i4d
    chmod +x "$safeTmp"/gpd-fan-driver/debian/rules

# https://github.com/soaringDistributions/gasket-driver/blob/4568a135dc7ac893a99972d03f7c86a4ab7ffb9a/debian/gasket-dkms.dkms
cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/gpd-fan-driver/debian/gpd-fan-driver-dkms.dkms
PACKAGE_NAME="gpd-fan-driver"
PACKAGE_VERSION="0.1"
AUTOINSTALL="yes"

BUILT_MODULE_NAME[0]="gpd-fan"
BUILT_MODULE_LOCATION[0]="./"
DEST_MODULE_LOCATION[0]="/extra"
MAKE[0]="make KERNEL_SRC=${kernel_source_dir}"
CLEAN="make clean"
CZXWXcRMTo8EmM8i4d

cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/gpd-fan-driver/debian/changelog
gpd-fan-driver-dkms (0.1-1) unstable; urgency=medium

  * Initial "source-only" DKMS packaging.

 -- Soaring Distributions LLC <not_yet@example.com>  Wed, 01 Jan 2025 12:34:56 +0000

CZXWXcRMTo8EmM8i4d





	cd "$safeTmp"/gpd-fan-driver/
    #dpkg-buildpackage -b -us -uc -tc
	debuild -us -uc -tc -b





    local currentDate
    currentDate=$(date +"%Y-%m-%d" | tr -dc '0-9\-')
    _safeRMR "$scriptLib"/install/gpd-fan-driver-"$currentDate"
    mkdir -p "$scriptLib"/install/gpd-fan-driver-"$currentDate"
    mv -f "$safeTmp"/*.deb "$scriptLib"/install/gpd-fan-driver-"$currentDate"/

    _stop
}
_build_prog() {
    "$scriptAbsoluteLocation" _build_prog_sequence "$@"
}












