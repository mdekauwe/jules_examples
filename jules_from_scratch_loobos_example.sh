#!/bin/bash

# Single point Loobos run
#
# Martin De Kauwes
#
# 23rd Sept 2022

fcm make -j 2 -f etc/fcm-make/make.cfg --news

#
## Build source
#

cd /home/users/mdekauwe/JULES

jules_src="vn6.0_hj"

if [ ! -d "$jules_src" ]; then
  fcm co https://code.metoffice.gov.uk/svn/jules/main/branches/dev/tobymarthews/vn6.0_hj vn6.0_hj
  cd vn6.0_hj
  fcm make -j 2 -f etc/fcm-make/make.cfg --new
fi

#
## Grab namelists
#

x

cd ~/roses

namelist_dir="nlists"
if [ ! -d "$namelist_dir" ]; then
  mkdir $namelist_dir
fi

cd $namelist_dir
rm *
rose app-run -i -C ~/roses/u-cg242/app/jules

#
## Run JULES
#

cd ~/.
/home/users/mdekauwe/JULES/$jules_src/build/bin/jules.exe ~/roses/nlists
