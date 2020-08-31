#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

#A53
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 25000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 90
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1401600
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "40 960000:50 1017600:60 1190400:70 1305600:80 1401600:90"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 45000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 1
#A72
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 883200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "15000 1382400:25000"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 80
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1382400
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "75 1382400:80 1747200:85"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 40000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 1
#Cpu-Boost
write /sys/module/cpu_boost/parameters/boost_ms 250
write /sys/module/cpu_boost/parameters/input_boost_enabled 1
write /sys/module/cpu_boost/parameters/input_boost_freq "0:1017600 1:1017600 2:1017600 3:1017600 4:1190400 5:1190400"
write /sys/module/cpu_boost/parameters/input_boost_ms 80
write /sys/module/msm_performance/parameters/touchboost 1
#Hotplug
write /sys/module/lazyplug/parameters/lazyplug_active 0
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
