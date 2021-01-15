#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}
echo 1 > /sys/devices/system/cpu/cpu0/online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu4/online
echo 1 > /sys/devices/system/cpu/cpu5/online
#Cpu Governor And Frequencies Scaling Settings
#A53
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 100 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 15000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 99 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads 
echo 25000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fastlane
echo 35 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fastlane_threshold
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost
#A72
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 
echo 1612800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 
echo "19000 1382400:39000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo 95 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo "60 883000:70 940000:75 1056000:80 " > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fastlane
echo 20 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fastlane_threshold
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost
#Cpu-Boost
echo 0 > /sys/module/cpu_boost/parameters/input_boost_enabled
echo "0:0 1:0 2:0 3:0 4:0 5:0" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms
#Hotplug
echo 1 > /sys/module/lazyplug/parameters/lazyplug_active
echo 4 > /sys/module/lazyplug/parameters/nr_run_profile_sel
echo 6 > /sys/module/lazyplug/parameters/nr_run_hysteresis
echo 500 > /sys/module/lazyplug/parameters/cpu_nr_run_threshold
#Workqueue
echo Y > /sys/module/workqueue/parameters/power_efficient 
#Scheduler
echo deadline > /sys/block/mmcblk0/queue/scheduler
echo deadline > /sys/block/mmcblk1/queue/scheduler
#Adreno-Driver and Gpu
echo Y > /sys/module/adreno_idler/parameters/adreno_idler_active 
echo 80 > /sys/module/adreno_idler/parameters/adreno_idler_downdiffrential 
echo 10 > /sys/module/adreno_idler/parameters/adreno_idler_idlewait 
echo 8000 > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload 
echo 0 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 
echo 550000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk 
echo 550000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
echo 266666667 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 
echo 4 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 
#Devfreq-Drivers
echo 0 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq
#Msm-Thermals
echo 45 > /sys/module/msm_thermal/parameters/temp_threshold 
echo 60 > /sys/module/msm_thermal/parameters/core_limit_temp_degC 
#Vmpressure
echo 100 > /proc/sys/vm/vfs_cache_pressure 
echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
