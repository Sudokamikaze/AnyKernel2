# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=SINAI-N4 by sudokamikaze @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=grouper

# Required for possible inline kernel flashing
if [ ! -f /recovery ] ; then
    alias gunzip="/tmp/anykernel/tools/busybox gunzip";
    alias cpio="/tmp/anykernel/tools/busybox cpio";
fi

} # end properties

# shell variables
block=/dev/block/platform/sdhci-tegra.3/by-name/LNX;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk

ui_print "    _____ _____   _____    ____";
ui_print "   / ___//  _/ | / /   |  /  _/";
ui_print "   \__ \ / //  |/ / /| |  / /  ";
ui_print "  ___/ // // /|  / ___ |_/ /   ";
ui_print " /____/___/_/ |_/_/  |_/___/   ";
ui_print "Infusing...";

## AnyKernel install
dump_boot;

# Ramdisk modifications

# init.mako.rc
# F2FS FSTAB
replace_file $ramdisk/fstab.grouper fstab.grouper

# Write to boot as ramdisk modifications are done
write_boot;
