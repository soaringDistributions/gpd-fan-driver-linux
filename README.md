
Copyright (C) 2024 SoaringDistributionsLLC
See the end of the file for license conditions.
See license.txt for gpd-fan-driver-linux license conditions.



GPD Win Mini 2024 8840U - is known to tolerate fan off for hours, at least with carefully applied liquid metal thermal interface material.

In any case, despite entirely valid and appropriate cautions from the developer of the relevant fan control Linux kernel module... it should be reasonable to set a low fan speed (~35%) at low temperature (<50degC), and then pass control to some other algorithm whenever this temperature is much exceeded, such as default automatic control. Guaranteeing the fan does not remain at this idle speed if loads increase should NOT be necessary - far more than several seconds to hours of delay increasing fan speed as a very rare worst case should not usually cause damage (ie. there may be significant but acceptable risk to purely software control of fan speed with this particular device).

Suggested fan curve:
35% 50degC
38% 65degC
38% 70degC
100% 80degC




# Prompt

Please help. There is an out-of-tree Linux kernel fan driver for the small pocketable GPD Win Mini 2024 8840U computer, which is essential, because it is not practical to sleep in the same room as that computer otherwise.

The repository for this Linux kernel module is available from this git compatible URL:
git@github.com:Cryolitia/gpd-fan-driver.git

Build systems have access to this repository, so it is preferable to use the SSH URL rather than the HTTPS URL.

Arch Linux repository enumerates this as the 'dkms.conf.in' file:
PACKAGE_NAME="gpd-fan-driver"
PACKAGE_VERSION=%%VERSION%%
AUTOINSTALL="yes"

BUILT_MODULE_NAME[0]="gpd-fan"
BUILT_MODULE_LOCATION[0]="./"
DEST_MODULE_LOCATION[0]="/extra"
MAKE[0]="make KERNEL_SRC=$kernel_source_dir"
CLEAN="make clean"


As an example, gasket-driver, the GoogleTPU PCIE driver, uses this debian/rules file, apparently to only compile the kernel modules after installation using DKMS.
#!/usr/bin/make -f

include /usr/share/dpkg/pkg-info.mk

%:
	dh $@ --with dkms

override_dh_install:
	dh_install src/* usr/src/gasket-$(DEB_VERSION_UPSTREAM)/

override_dh_dkms:
	dh_dkms -V $(DEB_VERSION_UPSTREAM)

override_dh_auto_configure:
override_dh_auto_build:
override_dh_auto_test:
override_dh_auto_install:
override_dh_auto_clean:


Now, please, based on this information, provide commands to run on a Debian Stable Linux system to create Debian packages which will only compile the kernel modules after installation using DKMS. It is not desirable to compile the kernel modules when just building the Debian package.



# Reference

https://github.com/Cryolitia/gpd-fan-driver
git@github.com:Cryolitia/gpd-fan-driver.git

https://aur.archlinux.org/packages/gpd-fan-driver-dkms-git

https://aur.archlinux.org/cgit/aur.git/tree/dkms.conf.in?h=gpd-fan-driver-dkms-git
https://aur.archlinux.org/cgit/aur.git/plain/dkms.conf.in?h=gpd-fan-driver-dkms-git

https://aur.archlinux.org/cgit/aur.git/tree/gpdfanspeed?h=gpd-fan-driver-dkms-git
https://aur.archlinux.org/cgit/aur.git/plain/gpdfanspeed?h=gpd-fan-driver-dkms-git



# Copyright

This file is part of gpd-fan-driver-linux.

gpd-fan-driver-linux is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

gpd-fan-driver-linux is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with gpd-fan-driver-linux.  If not, see <http://www.gnu.org/licenses/>.
