#!/bin/bash

# Single point Loobos run
#
# Martin De Kauwes
#
# 23rd Sept 2022


module load jaspy/3.7/r20210320

jules_src="vn6.0_hj"
namelist_dir="nlists"
rose_suite="u-cg242"

#
## Build source
#

cd /home/users/mdekauwe/JULES

if [ ! -d "$jules_src" ]; then
  #fcm co fcm:jules.x_tr@$jules_src $jules_src
  fcm co https://code.metoffice.gov.uk/svn/jules/main/branches/dev/tobymarthews/vn6.0_hj $jules_src

  cd $jules_src
  
  # Create normal JULES executable without NetCDF using the GFortran compiler 
  fcm make -j 2 -f etc/fcm-make/make.cfg --new
fi

#
## Grab namelists
#s

cd ~/roses


if [ ! -d "$namelist_dir" ]; then
  mkdir $namelist_dir
fi

cd $namelist_dir
rm *
rose app-run -i -C ~/roses/$rose_suite/app/jules

#
## Run JULES
#

cd ~/.
/home/users/mdekauwe/JULES/$jules_src/build/bin/jules.exe ~/roses/nlists
