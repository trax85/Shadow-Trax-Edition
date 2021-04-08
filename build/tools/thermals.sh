#!/sbin/sh
 #
 # Copyright � 2017, Umang Leekha "umang96" <umangleekha3@gmail.com> 
 #
 # Live ramdisk patching script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # Please maintain this if you use this script or any part of it
 #
 #
THERMAL=$(cat /tmp/aroma/thermal.prop | cut -d '=' -f2)
ROM=$(cat /tmp/aroma/rom.prop | cut -d '=' -f2)
#For Android 10 and higher
if [ $ROM == 3 ]; then
 if [ $THERMAL == 1 ]; then
    cp -R /tmp/old/vendor/ /system/system
    chmod 755 /system/system/vendor/bin/thermal-engine
    chmod 755 /system/system/vendor/lib/libthermalclient.so
    chmod 755 /system/system/vendor/lib64/libthermalclient.so
    chmod 755 /system/system/vendor/lib64/libthermalioctl.so
    chmod 644 /system/system/vendor/etc/thermal-engine.config
 fi
 if [ $THERMAL == 2 ]; then
    cp -R /tmp/new/vendor/ /system/system
    chmod 755 /system/system/vendor/bin/thermal-engine
    chmod 755 /system/system/vendor/lib/libthermalclient.so
    chmod 755 /system/system/vendor/lib64/libthermalclient.so
    chmod 755 /system/system/vendor/lib64/libthermalioctl.so
    chmod 644 /system/system/vendor/etc/thermal-engine.config
 fi
 if [ $THERMAL == 3 ]; then
    cp -R /tmp/cpuonly/vendor/ /system/system
    chmod 755 /system/system/vendor/bin/thermal-engine
    chmod 755 /system/system/vendor/lib/libthermalclient.so
    chmod 755 /system/system/vendor/lib64/libthermalclient.so
    chmod 755 /system/system/vendor/lib64/libthermalioctl.so
    chmod 644 /system/system/vendor/etc/thermal-engine.config
 fi
#For Pie And lower
else
 if [ $THERMAL == 1 ]; then
    cp -R /tmp/old/vendor/ /system
    chmod 755 /system/vendor/bin/thermal-engine
    chmod 755 /system/vendor/lib/libthermalclient.so
    chmod 755 /system/vendor/lib64/libthermalclient.so
    chmod 755 /system/vendor/lib64/libthermalioctl.so
    chmod 644 /system/vendor/etc/thermal-engine.config
 fi
 if [ $THERMAL == 2 ]; then
    cp -R /tmp/new/vendor/ /system
    chmod 755 /system/vendor/bin/thermal-engine
    chmod 755 /system/vendor/lib/libthermalclient.so
    chmod 755 /system/vendor/lib64/libthermalclient.so
    chmod 755 /system/vendor/lib64/libthermalioctl.so
    chmod 644 /system/vendor/etc/thermal-engine.config
 fi
 if [ $THERMAL == 3 ]; then
    cp -R /tmp/cpuonly/vendor/ /system
    chmod 755 /system/vendor/bin/thermal-engine
    chmod 755 /system/vendor/lib/libthermalclient.so
    chmod 755 /system/vendor/lib64/libthermalclient.so
    chmod 755 /system/vendor/lib64/libthermalioctl.so
    chmod 644 /system/vendor/etc/thermal-engine.config
 fi
fi
