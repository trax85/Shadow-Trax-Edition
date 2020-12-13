#!/sbin/sh

CONFIGFILE="/tmp/init.shadow.rc"
PROFILE=$(cat /tmp/aroma/profile.prop | cut -d '=' -f2)
if [ $PROFILE == 1 ]; then
PROF=0
elif [ $PROFILE == 2 ]; then
PROF=2
elif [ $PROFILE == 3 ]; then
PROF=1
fi
#
REFRESH=$(cat /tmp/aroma/refresh.prop | cut -d '=' -f2)
if [ $REFRESH == 2 ]; then
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
HAP=$(cat /tmp/aroma/haptic.prop | cut -d '=' -f2)
if [ $HAP == 1 ]; then
	HAPS=1856
elif [ $HAP == 2 ]; then
	HAPS=1334
elif [ $HAP == 3 ]; then
	HAPS=986
fi
#
PROFILE=$(cat /tmp/aroma/profile.prop | cut -d '=' -f2)
if [ $PROFILE == 1 ]; then
GOV="interactive"
BOOST="0"
FMS=400000
FMB=400000
FMAS=1440000
FMAB=1843200
AID=N
ABST=0
TBST=0
SWAP=40
VFS=100
GLVL=7
GFREQ=200000000
GMAXFREQ=600000000
TEMPTT=65
TEMPTL=45
LPA=1
LPT=1035
LPH=8
LPP=2
LPC=6
elif [ $PROFILE == 2 ]; then
GOV="cultivation"
BOOST="0"
FMS=400000
FMB=400000
FMAS=1305600
FMAB=1305600
AID=Y
ABST=0
TBST=0
SWAP=20
VFS=40
GLVL=8
GFREQ=133333333
GMAXFREQ=432000000
TEMPTT=60
TEMPTL=40
LPA=1
LPT=1050
LPH=11
LPP=4
LPC=6
elif [ $PROFILE == 3 ]; then
GOV="interactive"
BOOST="0:1305600 4:1305600"
FMS=691200
FMB=883200
FMAS=1440000
FMAB=1843200
AID=N
ABST=1
TBST=1
SWAP=30
VFS=100
GLVL=6
GFREQ=266666667
GMAXFREQ=710000000
TEMPTT=70
TEMPTL=50
LPA=0
LPT=1035
LPH=8
LPP=0
LPC=6
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
echo "# VARIABLES FOR SH" >> $CONFIGFILE
echo "" >> $CONFIGFILE

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
echo "write /sys/module/mdss_dsi/parameters/dsi_refreshrate " $RFS >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# WAKE GESTURES" >> $CONFIGFILE
echo "write /sys/android_touch/doubletap2wake " $DT2W >> $CONFIGFILE
echo "write /sys/android_touch/sweep2wake " $S2W >> $CONFIGFILE
echo "write /sys/android_touch/vib_strength " $VIBS >> $CONFIGFILE
COLOR=$(cat /tmp/aroma/color.prop | cut -d '=' -f2)
echo "# KCAL" >> $CONFIGFILE
if [ $COLOR == 1 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 285" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 265" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"254 252 230"\" >> $CONFIGFILE
elif [ $COLOR == 2 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 269" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 256" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"254 254 240"\" >> $CONFIGFILE
elif [ $COLOR == 3 ]; then
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_sat 287" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_val 257" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal_cont 265" >> $CONFIGFILE
	echo "write /sys/devices/platform/kcal_ctrl.0/kcal \"256 254 240"\" >> $CONFIGFILE
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
	echo "# CHARGING RATE" >> $CONFIGFILE
	echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma" >> $CONFIGFILE
	echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma" >> $CONFIGFILE
	echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma" >> $CONFIGFILE
	echo "write /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma $RATE" >> $CONFIGFILE
	echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma $RATE" >> $CONFIGFILE
	echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma $RATE" >> $CONFIGFILE
fi
echo "# FAST CHARGE" >> $CONFIGFILE
echo "write /sys/kernel/fast_charge/force_fast_charge $USB" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# DISABLE BCL & CORE CTL" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_soc_mask 0" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# ENABLE BCL & CORE CTL" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/core_control/enabled 0">> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode disable" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_mask 48" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/hotplug_soc_mask 32" >> $CONFIGFILE
echo "write /sys/devices/soc.0/qcom,bcl.56/mode enable" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# SET IO SCHEDULER" >> $CONFIGFILE
if [ $PROFILE == 1 ]; then
	echo "setprop sys.io.scheduler \"maple\"" >> $CONFIGFILE
elif [ $PROFILE == 2 ]; then
	echo "setprop sys.io.scheduler \"fiops\"" >> $CONFIGFILE
elif [ $PROFILE == 3 ]; then
	echo "setprop sys.io.scheduler \"deadline\"" >> $CONFIGFILE
fi
echo "# HAPTIC FEEDBACK SENSOR" >> $CONFIGFILE
echo "write /sys/class/timed_output/vibrator/vtg_level $HAPS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 256" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# TOUCH BOOST" >> $CONFIGFILE
echo "write /sys/module/msm_performance/parameters/touchboost $TBST" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# ADRENO IDLER" >> $CONFIGFILE
echo "write /sys/module/adreno_idler/parameters/adreno_idler_active $AID" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# ADRENO BOOST" >> $CONFIGFILE
echo "write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost $ABST" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# FSYNC" >> $CONFIGFILE
echo "write /sys/module/sync/parameters/fsync_enabled $DFS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
BDM=`grep "item.0.3" /tmp/aroma/mods.prop | cut -d '=' -f2`
if [ $BDM = 1 ]; then
	echo "write /sys/module/mdss_fb/parameters/backlight_dimmer Y" >> $CONFIGFILE
elif [ $BDM = 0 ]; then
	echo "write /sys/module/mdss_fb/parameters/backlight_dimmer N" >> $CONFIGFILE
fi
echo "write /sys/block/mmcblk0/queue/iostats 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/iostats 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# KSM" >> $CONFIGFILE
echo "write /sys/kernel/mm/ksm/run 0" >> $CONFIGFILE
echo "write /sys/kernel/mm/ksm/run_charging 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# CPU SCHEDULER" >> $CONFIGFILE
echo "chmod 755 /proc/sys/kernel/sched_boost" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_boost 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_inc_notify 400000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_freq_dec_notify 400000" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_wake_to_idle 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# SHADOW SCHEDULING" >> $CONFIGFILE
echo "chmod 755 /proc/sys/kernel/sched_use_shadow_scheduling" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_use_shadow_scheduling 1" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_shadow_downmigrate 80" >> $CONFIGFILE
echo "write /proc/sys/kernel/sched_shadow_upmigrate 85" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# DCVS" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/governor \"bw_hwmon\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/io_percent 34" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/guard_band_mbps 100" >> $CONFIGFILE
echo "write /sys/class/devfreq/qcom,memlat-cpu0.51/polling_interval 10" >> $CONFIGFILE
echo "write /sys/class/devfreq/qcom,memlat-cpu4.52/polling_interval 10" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# FP BOOST" >> $CONFIGFILE
echo "write /sys/kernel/fp_boost/enabled 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
VOLT=$(cat /tmp/aroma/uv.prop | cut -d '=' -f2)
if [ $VOLT == 1 ]; then
	echo "# CPU & GPU EXTREME UV" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"680 700 760 800 860 910 970 1030 1050\"" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"540 540 580 760 860 910 930 940 950 1030 1120 680 700 720 780 810 810 820 900 950 960\"" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
if [ $VOLT == 2 ]; then
	echo "# CPU & GPU HEAVY UV" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"680 700 760 800 860 910 970 1030 1050\"" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"680 710 760 780 880 910 930 940 950 1030 1120 680 700 740 800 810 810 820 900 950 960\"" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
elif [ $VOLT == 3 ]; then
	echo "# CPU & GPU LIGHT UV" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"700 720 770 820 880 940 970 1030 1050\"" >> $CONFIGFILE
	echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"720 730 750 880 920 930 940 950 980 1060 1140 710 720 760 800 830 850 870 950 960 980\"" >> $CONFIGFILE
	echo "" >> $CONFIGFILE
fi
echo "# MISC TWEAKS" >> $CONFIGFILE
echo "setprop video.accelerate.hw 1" >> $CONFIGFILE
echo "setprop debug.composition.type c2d" >> $CONFIGFILE
echo "/sys/kernel/debug/debug_enabled N" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# RUN USERTWEAKS SERVICE" >> $CONFIGFILE
echo "start usertweaks" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "" >> $CONFIGFILE
if [ $ROM -eq 2 ] || [ $ROM -eq 1 ]; then
echo "# INITIALIZE AND RUN SPECTRUM TWEAKS" >> $CONFIGFILE
echo "setprop spectrum.support 1" >> $CONFIGFILE
echo "setprop persist.spectrum.kernel \"Shadow TraxEdition HMP\""  >> $CONFIGFILE
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
fi
