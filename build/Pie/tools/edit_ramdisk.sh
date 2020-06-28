#!/sbin/sh
#Shadow-EAS Ramdisk Edits 
CONFIGFILE="/tmp/init.shadow.rc"
PROFILE=$(cat /tmp/aroma/profile.prop | cut -d '=' -f2)
if [ $PROFILE == 1 ]; then
PROF=0
elif [ $PROFILE == 2 ]; then
PROF=2
elif [ $PROFILE == 3 ]; then
PROF=1
fi

DFSC=`grep "item.0.1" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $DFSC = 1 ]; then
	DFS=0
elif [ $DFSC = 0 ]; then
	DFS=1
fi

FC=`grep "item.0.2" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $FC = 1 ]; then
	USB=1
elif [ $FC = 0 ]; then
	USB=0
fi

REFRESH=$(cat /tmp/aroma/refresh.prop | cut -d '=' -f2)
if [ $REFRESH == 1 ]; then
	RFS=60
elif [ $REFRESH == 2 ]; then
	RFS=62
elif [ $REFRESH == 3 ]; then
	RFS=64
elif [ $REFRESH == 4 ]; then
	RFS=66
elif [ $REFRESH == 5 ]; then
	RFS=68
elif [ $REFRESH == 6 ]; then
	RFS=70
fi

DT2W=$(cat /tmp/aroma/wake.prop | grep -e "dt2w" | cut -d '=' -f2)
if [ $DT2W == 1 ]; then
	DT2W=1
elif [ $DT2W == 2 ]; then
	DT2W=0
fi

S2W=$(cat /tmp/aroma/wake.prop | grep -e "s2w" | cut -d '=' -f2)
if [ $S2W == 1 ]; then
	S2W=4
elif [ $S2W == 2 ]; then
	S2W=0
fi

VIBS=$(cat /tmp/aroma/wake.prop | grep -e "vibs" | cut -d '=' -f2)
if [ $VIBS == 1 ]; then
	VIBS=50
elif [ $VIBS == 2 ]; then
	VIBS=30
elif [ $VIBS == 3 ]; then
	VIBS=0
fi

ZRAM=$(cat /tmp/aroma/ram.prop | cut -d '=' -f2)

ROM=$(cat /tmp/aroma/rom.prop | cut -d '=' -f2)
echo "# USER TWEAKS" >> $CONFIGFILE
if [ $ROM -eq 2 ] || [ $ROM -eq 1 ]; then
if [ $ZRAM -eq 1 ]; then
    echo "service usertweaks /system/bin/sh /system/etc/shadow.sh" >> $CONFIGFILE
else
    echo "service usertweaks /system/bin/sh /system/etc/shadow-zram.sh" >> $CONFIGFILE
fi
	echo "class main" >> $CONFIGFILE
	echo "group root" >> $CONFIGFILE
	echo "user root" >> $CONFIGFILE
	echo "oneshot" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
	echo "service spectrum /system/bin/sh /init.spectrum.sh" >> $CONFIGFILE
	echo "class late_start" >> $CONFIGFILE
	echo "user root" >> $CONFIGFILE
	echo "disabled" >> $CONFIGFILE
	echo "oneshot" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
	echo "on init" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
	echo "on property:sys.boot_completed=1" >> $CONFIGFILE
else
if [ $ZRAM -eq 1 ]; then
    echo "service usertweaks /system/bin/sh /vendor/etc/shadow.sh" >> $CONFIGFILE
else
    echo "service usertweaks /system/bin/sh /vendor/etc/shadow-zram.sh" >> $CONFIGFILE
fi
	echo "class main" >> $CONFIGFILE
	echo "group root" >> $CONFIGFILE
	echo "user root" >> $CONFIGFILE
	echo "oneshot" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
	echo "service spectrum /system/bin/sh /vendor/etc/init/hw/init.spectrum.sh" >> $CONFIGFILE
	echo "class late_start" >> $CONFIGFILE
	echo "user root" >> $CONFIGFILE
	echo "disabled" >> $CONFIGFILE
	echo "oneshot" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
	echo "on init" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
	echo "on property:init.svc.vendor.qcom-post-boot=stopped" >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
echo "# REFRESHRATE" >> $CONFIGFILE
echo "chmod 666 /sys/module/mdss_dsi/parameters/dsi_refreshrate" >> $CONFIGFILE
echo "write /sys/module/mdss_dsi/parameters/dsi_refreshrate $RFS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
COLOR=$(cat /tmp/aroma/color.prop | cut -d '=' -f2)
echo "# KCAL" >> $CONFIGFILE
if [ $COLOR == 1 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 269" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"254 252 230"\" >> $CONFIGFILE
elif [ $COLOR == 2 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 269" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"254 254 240"\" >> $CONFIGFILE
elif [ $COLOR == 3 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 270" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 257" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 265" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"256 256 256"\" >> $CONFIGFILE
elif [ $COLOR == 4 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 255" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 255" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 255" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"256 256 256"\" >> $CONFIGFILE
fi
echo "write /sys/devices/platform/kcal_ctrl.0/kcal_enable 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
CHG=$(cat /tmp/aroma/charge.prop | cut -d '=' -f2)
if [ $CHG == 1 ]; then
	RATE=1400
	echo "# CHARGE RATE" >> $CONFIGFILE
	echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma" >> $CONFIGFILE
	echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma" >> $CONFIGFILE
	echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma" >> $CONFIGFILE
	echo "write /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma " $RATE >> $CONFIGFILE
	echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma " $RATE >> $CONFIGFILE
	echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma " $RATE >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
echo "# DISABLE BCL & CORE CTL" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_soc_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# BRING CORES ONLINE" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu1/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu2/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu3/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu5/online 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# WAKE GESTURES" >> $CONFIGFILE
echo "write /sys/android_touch/doubletap2wake " $DT2W >> $CONFIGFILE
echo "write /sys/android_touch/sweep2wake " $S2W >> $CONFIGFILE
echo "write /sys/android_touch/vib_strength " $VIBS >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 256" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# FSYNC" >> $CONFIGFILE
echo "write /sys/module/sync/parameters/fsync_enabled $DFS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
BDM=`grep "item.0.3" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $DFSC = 1 ]; then
	echo "write /sys/module/mdss_fb/parameters/backlight_dimmer Y" >> $CONFIGFILE
elif [ $DFSC = 0 ]; then
	echo "write /sys/module/mdss_fb/parameters/backlight_dimmer N" >> $CONFIGFILE
fi
echo "write /sys/block/mmcblk0/queue/iostats 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/iostats 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "# DCVS" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/governor \"bw_hwmon\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/io_percent 34" >> $CONFIGFILE
echo "write /sys/class/devfreq/qcom,memlat-cpu0.51/polling_interval 10" >> $CONFIGFILE
echo "write /sys/class/devfreq/qcom,memlat-cpu4.52/polling_interval 20" >> $CONFIGFILE
echo "" >> $CONFIGFILE

VOLT=$(cat /tmp/aroma/uv.prop | cut -d '=' -f2)
if [ $VOLT == 1 ]; then
	echo "# CPU & GPU HEAVY UV" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"680 700 760 800 860 910 970 1030 1050\"" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"680 710 760 790 890 920 930 940 950 680 700 740 800 810 810 820 900 950 960\"" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
elif [ $VOLT == 2 ]; then
	echo "# CPU & GPU LIGHT UV" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"700 720 770 820 880 940 970 1030 1050\"" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"720 730 750 880 920 930 940 950 980 710 720 760 800 830 850 870 950 960 980\"" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
fi
echo "# MISC" >> $CONFIGFILE
echo "setprop video.accelerate.hw 1" >> $CONFIGFILE
echo "setprop debug.composition.type c2d" >> $CONFIGFILE
echo "write /sys/kernel/debug/debug_enabled N" >> $CONFIGFILE

echo "" >> $CONFIGFILE
echo "# USB FASTCHARGE" >> $CONFIGFILE
echo "write /sys/kernel/fast_charge/force_fast_charge $USB" >> $CONFIGFILE
echo "" >> $CONFIGFILE

echo "# RUN USERTWEAKS SERVICE" >> $CONFIGFILE
echo "start usertweaks" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# INITIALIZE AND RUN SPECTRUM TWEAKS" >> $CONFIGFILE
echo "setprop spectrum.support 1" >> $CONFIGFILE
echo "setprop persist.spectrum.kernel \"Shadow TraxEdition\""  >> $CONFIGFILE
echo "setprop persist.spectrum.profile $PROF" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on property:persist.spectrum.profile=0" >> $CONFIGFILE
echo "start spectrum" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on property:persist.spectrum.profile=1" >> $CONFIGFILE
echo "start spectrum" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on property:persist.spectrum.profile=2" >> $CONFIGFILE
echo "start spectrum" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on property:persist.spectrum.profile=3" >> $CONFIGFILE
echo "start spectrum" >> $CONFIGFILE
echo "" >> $CONFIGFILE
