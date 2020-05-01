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
zim=/tmp/Image1
dim=/tmp/dt1.img
cmd="androidboot.hardware=qcom ehci-hcd.park=3 androidboot.bootdevice=7824900.sdhci lpm_levels.sleep_disabled=1 ramoops_memreserve=4M"
cmd=$cmd" androidboot.selinux=permissive"
cmd=$cmd" cpu_max_c1=1440000"" cpu_max_c2=1843200"
AUDIO=`grep "item.0.3" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $AUDIO = 1 ]; then
	cmd=$cmd" snd-soc-msm8x16-wcd.dig_core_collapse_enable=0"
fi
JACK=`grep "item.0.4" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $JACK = 0 ]; then
	cmd=$cmd" android.audiojackmode=stock"
fi
ROM=$(cat /tmp/aroma/rom.prop | cut -d '=' -f2)
cp -f /tmp/cpio /sbin/cpio
cd /tmp/
/sbin/busybox dd if=/dev/block/bootdevice/by-name/boot of=./boot.img
./unpackbootimg -i /tmp/boot.img
if [ $ROM == 3 ]; then
	cp /tmp/shadow.sh /system/system/vendor/etc/shadow.sh
	chmod 755 /system/system/vendor/etc/shadow.sh
	cp /tmp/init.shadow.rc /system/system/vendor/etc/init/hw/
	chmod 0644 /system/system/vendor/etc/init/hw/init.shadow.rc
	# ADD SPECTRUM SUPPORT
	cp /tmp/init.spectrum.sh /system/system/vendor/etc/init/hw/
	chmod 755 /system/system/vendor/etc/init/hw/init.spectrum.sh
	if [ $(grep -c "import /vendor/etc/init/hw/init.shadow.rc" /system/system/vendor/etc/init/hw/init.qcom.rc) == 0 ]; then
		cp -p /system/system/vendor/etc/init/hw/init.qcom.rc /system/system/vendor/etc/init/hw/init.qcom.rc.bak
		insert_line /system/system/vendor/etc/init/hw/init.qcom.rc "import /vendor/etc/init/hw/init.shadow.rc" after "import /vendor/etc/init/hw/init.target.rc" "import /vendor/etc/init/hw/init.shadow.rc"
	fi
	# COMPATIBILITY FIXES START
	cp /tmp/gxfingerprint.default.so /system/system/vendor/lib64/hw/gxfingerprint.default.so
	# COMPATIBILITY FIXES END
else
	cp /tmp/shadow.sh /system/etc/shadow.sh
	chmod 755 /system/etc/shadow.sh
	cp -f /tmp/cpio /sbin/cpio
	cd /tmp/
	/sbin/busybox dd if=/dev/block/bootdevice/by-name/boot of=./boot.img
	./unpackbootimg -i /tmp/boot.img
	mkdir /tmp/ramdisk
	cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
	cd /tmp/ramdisk/
	gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | /tmp/cpio -i
	rm /tmp/ramdisk/boot.img-ramdisk.gz
	rm /tmp/boot.img-ramdisk.gz
	cp /tmp/init.shadow.rc /tmp/ramdisk/
	# ADD SPECTRUM SUPPORT
	cp /tmp/init.spectrum.rc /tmp/ramdisk/
	cp /tmp/init.spectrum.sh /tmp/ramdisk/
	# COMPATIBILITY FIXES START
	if [ $ROM == 2 ]; then
		cp /tmp/gxfingerprint.default.so /system/vendor/lib64/hw/gxfingerprint.default.so
	else
		cp /tmp/gxfingerprint.default.so /system/lib64/hw/gxfingerprint.default.so
	fi
	#
        if [ $ROM == 1 ]; then
	  if [ $(grep -c "lazytime" fstab.qcom) -ne 0 ]; then
		 cp /tmp/fstab.qcom /tmp/ramdisk/
		 chmod 640 /tmp/ramdisk/fstab.qcom
	  fi
        fi
	if [ -f /tmp/ramdisk/init.darkness.rc ]; then
		rm /tmp/ramdisk/init.darkness.rc
	fi
	if [ -f /tmp/ramdisk/init.radon.rc ]; then
		rm /tmp/ramdisk/init.radon.rc
	fi
	# COMPATIBILITY FIXES END
	chmod 0750 /tmp/ramdisk/init.shadow.rc
	if [ $(grep -c "import /init.shadow.rc" /tmp/ramdisk/init.rc) == 0 ]; then
	   sed -i "/import \/init\.\${ro.hardware}\.rc/aimport /init.shadow.rc" /tmp/ramdisk/init.rc
	fi
        chmod 0750 /tmp/ramdisk/init.spectrum.rc
        if [ $(grep -c "import /init.spectrum.rc" /tmp/ramdisk/init.rc) == 0 ]; then
           sed -i "/import \/init\.\${ro.hardware}\.rc/aimport /init.spectrum.rc" /tmp/ramdisk/init.rc
        fi 
	find . | cpio -o -H newc | gzip > /tmp/boot.img-ramdisk.gz
	rm -r /tmp/ramdisk
	cd /tmp/
fi
./mkbootimg --kernel $zim --ramdisk /tmp/boot.img-ramdisk.gz --cmdline "$cmd"  --base 0x80000000 --pagesize 2048 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --dt $dim -o /tmp/newboot.img
/sbin/busybox dd if=/tmp/newboot.img of=/dev/block/bootdevice/by-name/boot
