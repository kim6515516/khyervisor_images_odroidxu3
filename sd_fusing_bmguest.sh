#
# Copyright (C) 2013 Samsung Electronics Co., Ltd.
#              http://www.samsung.com/
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#
####################################

if [ -z $1 ]
then
    echo "usage: ./sd_fusing.sh <SD Reader's device file>"
    exit 0
fi

if [ -b $1 ]
then
    echo "$1 reader is identified."
else
    echo "$1 is NOT identified."
    exit 0
fi

####################################
# fusing images
signed_bl1_position=1
bl2_position=31
uboot_position=63
tzsw_position=719
hypervisor=1263

guest0=1919
guest1=10112

bmguest0=18305
bmguest1=26498

guest0temp=34691
guest1temp=42884

#<BL1 fusing>
echo "BL1 fusing"
dd iflag=dsync oflag=dsync if=./bl1.bin of=$1 seek=$signed_bl1_position

#<BL2 fusing>
echo "BL2 fusing"
dd iflag=dsync oflag=dsync if=./bl2.bin of=$1 seek=$bl2_position

#<u-boot fusing>
echo "u-boot fusing"
dd iflag=dsync oflag=dsync if=./u-boot.bin of=$1 seek=$uboot_position

#<TrustZone S/W fusing>
echo "TrustZone S/W fusing"
dd iflag=dsync oflag=dsync if=./tzsw.bin of=$1 seek=$tzsw_position

echo "hypervisor fusing"
dd iflag=dsync oflag=dsync if=./hvc-man-switch.bin of=$1 seek=$hypervisor

echo "guest0 fusing"
dd iflag=dsync oflag=dsync if=./guest0.bin of=$1 seek=$guest0

echo "guest1 fusing"
dd iflag=dsync oflag=dsync if=./guest1.bin of=$1 seek=$guest1

echo "bmguest0 fusing"
dd iflag=dsync oflag=dsync if=./bmguest0.bin of=$1 seek=$bmguest0

echo "bmguest1 fusing"
dd iflag=dsync oflag=dsync if=./bmguest1.bin of=$1 seek=$bmguest1

echo "guest0_temp fusing"
dd iflag=dsync oflag=dsync if=./guest0_copy.bin of=$1 seek=$guest0temp

echo "guest1_temp fusing"
dd iflag=dsync oflag=dsync if=./guest1_copy.bin of=$1 seek=$guest1temp




####################################
#<Message Display>
echo "U-boot image is fused successfully."
echo "Eject SD card and insert it again."
