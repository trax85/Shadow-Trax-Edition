#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online
#A53
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 75 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 
echo 25000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
echo "80 960000:30 1017600:40 1190400:50 1305600:60 1401600:75" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fastlane
echo 50 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fastlane_threshold
#A72
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 883200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo 50 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
echo "15000 1382400:25000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay 
echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo "50 1190400:35 1382400:50 1612800:60 1747200:70 1804800:75" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo 45000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fastlane
echo 50 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fastlane_threshold
#Cpu-Boost
echo 0 > /sys/module/cpu_boost/parameters/input_boost_enabled
echo "0:1305600 1:1305600 2:1305600 3:1305600 4:1190400 5:1190400" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 500 > /sys/module/cpu_boost/parameters/input_boost_ms
#Hotplug
echo 0 > /sys/module/lazyplug/parameters/lazyplug_active
#Workqueue
echo N > /sys/module/workqueue/parameters/power_efficient
#Scheduler
echo deadline > /sys/block/mmcblk0/queue/scheduler
echo deadline > /sys/block/mmcblk1/queue/scheduler
#Adreno-Driver and Gpu
echo N > /sys/module/adreno_idler/parameters/adreno_idler_active
echo 2 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
echo 710000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
echo 266666667 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
echo 2 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
#Devfreq-Drivers
echo 805 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq
#Msm-Thermals
echo 50 > /sys/module/msm_thermal/parameters/temp_threshold
echo 75 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
#Vmpressure
echo 100 > /proc/sys/vm/vfs_cache_pressure
