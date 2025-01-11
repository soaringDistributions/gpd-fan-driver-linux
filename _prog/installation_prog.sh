
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

    mkdir -p "$safeTmp"/debian

    # https://en.wikipedia.org/wiki/Debian_version_history#Debian_12_(Bookworm)
    cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/debian/control
Source: gpd-fan-driver
Maintainer: Your Name <you@example.com>
Section: kernel
Priority: optional
Standards-Version: 4.6.1
Build-Depends: debhelper-compat (= 12), dkms
Rules-Requires-Root: no

Package: gpd-fan-driver-dkms
Architecture: all
Depends: dkms (>= 2.1.0.0), ${misc:Depends}
Description: GPD Win Mini fan driver kernel module (DKMS)
 The gpd-fan driver is an out-of-tree kernel module providing fan control
 for the GPD Win Mini device. This package uses DKMS for automatic
 recompilation of the module when new kernels are installed.
 
 https://github.com/Cryolitia/gpd-fan-driver
 git@github.com:Cryolitia/gpd-fan-driver.git
 
 https://aur.archlinux.org/packages/gpd-fan-driver-dkms-git
 
 https://aur.archlinux.org/cgit/aur.git/tree/dkms.conf.in?h=gpd-fan-driver-dkms-git
 https://aur.archlinux.org/cgit/aur.git/plain/dkms.conf.in?h=gpd-fan-driver-dkms-git
 
 https://aur.archlinux.org/cgit/aur.git/tree/gpdfanspeed?h=gpd-fan-driver-dkms-git
 https://aur.archlinux.org/cgit/aur.git/plain/gpdfanspeed?h=gpd-fan-driver-dkms-git
 
 https://github.com/soaringDistributions/gpd-fan-driver
 
 
 
CZXWXcRMTo8EmM8i4d

    # https://en.wikipedia.org/wiki/Debian_version_history#Debian_12_(Bookworm)
    cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/debian/compat
12
CZXWXcRMTo8EmM8i4d

    cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/debian/rules
#!/usr/bin/make -f

%:
	dh $@

override_dh_auto_build:
	# No special build steps needed aside from what dkms does, but
	# if you want to run 'make' manually, do it here.
	# e.g., make -C src
	dh_auto_build

override_dh_auto_install:
	# No special install steps needed; we rely on dh_dkms
	dh_auto_install
	dh_dkms

CZXWXcRMTo8EmM8i4d
    chmod +x "$safeTmp"/debian/rules

cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/debian/gpd-fan-driver-dkms.dkms
PACKAGE_NAME="gpd-fan-driver"
PACKAGE_VERSION="%%VERSION%%"
AUTOINSTALL="yes"

BUILT_MODULE_NAME[0]="gpd-fan"
BUILT_MODULE_LOCATION[0]="./"
DEST_MODULE_LOCATION[0]="/extra"
MAKE[0]="make KERNEL_SRC=${kernel_source_dir}"
CLEAN="make clean"
CZXWXcRMTo8EmM8i4d

cat << 'CZXWXcRMTo8EmM8i4d' > "$safeTmp"/debian/changelog
gpd-fan-driver (1.0-1) unstable; urgency=medium

  * Initial release of gpd-fan-driver DKMS package.

 -- Your Name <you@example.com>  $(date -R)
CZXWXcRMTo8EmM8i4d







    dpkg-buildpackage -b -us -uc





    _stop
}
_build_prog() {
    "$scriptAbsoluteLocation" _build_prog_sequence "$@"
}












