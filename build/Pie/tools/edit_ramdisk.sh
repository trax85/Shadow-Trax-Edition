#!/sbin/sh

CONFIGFILE="/tmp/init.shadow.rc"
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
SWAP=60
VFS=100
GLVL=6
GFREQ=266666667
GMAXFREQ=600000000
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
echo "on init" >> $CONFIGFILE
echo "chmod 666 /sys/module/mdss_dsi/parameters/dsi_refreshrate" >> $CONFIGFILE
echo "write /sys/module/mdss_dsi/parameters/dsi_refreshrate $RFS" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# VARIABLES FOR SH" >> $CONFIGFILE
echo "" >> $CONFIGFILE
RAM=$(cat /tmp/aroma/ram.prop | cut -d '=' -f2)
echo "# USER TWEAKS" >> $CONFIGFILE
if [ $RAM == 2 ]; then
echo "service usertweaks /system/bin/sh /system/etc/shadow.sh" >> $CONFIGFILE
fi
echo "class main" >> $CONFIGFILE
echo "group root" >> $CONFIGFILE
echo "user root" >> $CONFIGFILE
echo "oneshot" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "on property:dev.bootcomplete=1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "#zrammode" >> $CONFIGFILE
if [ $RAM == 2 ]; then
SWAP=0
fi 
echo "# SWAPPINESS AND VFS CACHE PRESSURE" >> $CONFIGFILE
echo "write /proc/sys/vm/swappiness $SWAP" >> $CONFIGFILE
echo "write /proc/sys/vm/vfs_cache_pressure $VFS" >> $CONFIGFILE
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
echo "# CHARGE RATE" >> $CONFIGFILE
echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma" >> $CONFIGFILE
echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma" >> $CONFIGFILE
echo "chmod 666 /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma" >> $CONFIGFILE
echo "write /sys/module/qpnp_smbcharger/parameters/default_dcp_icl_ma 2000" >> $CONFIGFILE
echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp_icl_ma 2000" >> $CONFIGFILE
echo "write /sys/module/qpnp_smbcharger/parameters/default_hvdcp3_icl_ma 2000" >> $CONFIGFILE
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
echo "# TWEAK A53 CLUSTER GOVERNOR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor \"$GOV\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq $FMS" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq $FMAS" >> $CONFIGFILE
if [ $PROFILE == 1 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads \"99\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0" >> $CONFIGFILE
elif [ $PROFILE == 2 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/go_hispeed_load 99" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/above_hispeed_delay 30000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/hispeed_freq 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/min_sample_time 45000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/timer_rate 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/max_freq_hysteresis 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/timer_slack -1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/powersave_bias 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/fastlane 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/align_windows 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/target_loads \"60 400000:25 691200:40 1017600:55 1190400:85 1305600:99"\" >> $CONFIGFILE
elif [ $PROFILE == 3 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay \"25000\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 95" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads \"99\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 45000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
echo "# TWEAK A72 CLUSTER GOVERNOR" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/online 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor \"$GOV\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq $FMB" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq $FMAB" >> $CONFIGFILE
if [ $PROFILE == 1 ]; then
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay \"19000 1382400:39000\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 90" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1113600" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads \"85 1382400:90 1747200:95\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0" >> $CONFIGFILE
elif [ $PROFILE == 2 ]; then
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/go_hispeed_load 99" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/above_hispeed_delay 25000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/hispeed_freq 1113600" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/min_sample_time 30000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/timer_rate 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/max_freq_hysteresis 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/timer_slack -1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/powersave_bias 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/fastlane 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/align_windows 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/target_loads \"90"\" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/use_sched_load 0" >> $CONFIGFILE
elif [ $PROFILE == 3 ]; then
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay \"15000 1382400:25000\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 80" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1382400" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads \"75 1382400:80 1747200:85\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 40000" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 0" >> $CONFIGFILE
fi
echo "" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/read_ahead_kb 256" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# TOUCH BOOST" >> $CONFIGFILE
echo "write /sys/module/msm_performance/parameters/touchboost $TBST" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# ADRENO IDLER" >> $CONFIGFILE
echo "write /sys/module/adreno_idler/parameters/adreno_idler_active $AID" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# FSYNC" >> $CONFIGFILE
echo "write /sys/module/sync/parameters/fsync_enabled 1" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "write /sys/module/mdss_fb/parameters/backlight_dimmer y" >> $CONFIGFILE
echo "write /sys/block/mmcblk0/queue/iostats 0" >> $CONFIGFILE
echo "write /sys/block/mmcblk1/queue/iostats 0" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# THERMAL SETTINGS" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/parameters/enabled y" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/parameters/temp_threshold $TEMPTL" >> $CONFIGFILE
echo "write /sys/module/msm_thermal/parameters/core_limit_temp_degC $TEMPTT" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# KSM" >> $CONFIGFILE
echo "write /sys/kernel/mm/ksm/run 0" >> $CONFIGFILE
echo "write /sys/kernel/mm/ksm/run_charging 0" >> $CONFIGFILE
echo "# DCVS" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/governor \"bw_hwmon\"" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/io_percent 34" >> $CONFIGFILE
echo "write /sys/class/devfreq/cpubw/bw_hwmon/guard_band_mbps 100" >> $CONFIGFILE
echo "write /sys/class/devfreq/qcom,memlat-cpu0.51/polling_interval 10" >> $CONFIGFILE
echo "write /sys/class/devfreq/qcom,memlat-cpu4.52/polling_interval 10" >> $CONFIGFILE
echo "" >> $CONFIGFILE
echo "# POWERSUSPEND" >> $CONFIGFILE
echo "write /sys/kernel/power_suspend/power_suspend_mode 3" >> $CONFIGFILE
echo "" >> $CONFIGFILE
VOLT=$(cat /tmp/aroma/uv.prop | cut -d '=' -f2)
echo "# CPU & GPU UV" >> $CONFIGFILE
if [ $VOLT == 1 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"710 720 760 800 860 910 970 1030 1050\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"700 720 740 860 900 920 930 940 950 700 710 830 860 920 940 950 980\"" >> $CONFIGFILE
elif [ $VOLT == 2 ]; then
echo "write /sys/devices/system/cpu/cpu0/cpufreq/GPU_mV_table \"720 720 770 820 880 940 970 1030 1050\"" >> $CONFIGFILE
echo "write /sys/devices/system/cpu/cpu0/cpufreq/UV_mV_table \"720 730 750 880 920 940 950 960 970 720 730 850 880 950 960 970 990\"" >>
echo "" >> $CONFIGFILE
fi
echo "# RUN USERTWEAKS SERVICE" >> $CONFIGFILE
echo "start usertweaks" >> $CONFIGFILE
echo "" >> $CONFIGFILE
