# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() {
kernel.string=DirtyV by bsmitty83 @ xda-developers
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=1
device.name1=mako
} # end properties

# shell variables
block=/dev/block/platform/omap/omap_hsmmc.0/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;


## AnyKernel install
dump_boot;

ui_print "    _____ _____   _____    ____";
ui_print "   / ___//  _/ | / /   |  /  _/";
ui_print "   \__ \ / //  |/ / /| |  / /  ";
ui_print "  ___/ // // /|  / ___ |_/ /   ";
ui_print " /____/___/_/ |_/_/  |_/___/   ";


# begin ramdisk changes

# Add init.sinai.rc
insert_line init.mako.rc "init.sinai.rc" after "init.mako_tiny.rc" "import init.sinai.rc";

# Disable mpdecision and thermald (Based on Franco's implementation for Flo)
replace_section init.mako.rc "service thermald" "group radio" "service thermald /system/bin/thermald\n    class main\n    group radio system\n    disabled";
replace_section init.mako.rc "service mpdecision" "group root system" "service mpdecision /system/bin/mpdecision --no_sleep --avg_comp\n    class main\n    user root\n    group root system\n    disabled"; 

# end ramdisk changes

write_boot;

## end install

