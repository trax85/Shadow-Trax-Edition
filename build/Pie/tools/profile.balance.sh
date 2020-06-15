#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}
#Cpu Governor And Frequencies Scaling Settings
#A53
echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 15000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "99"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 25000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0
#A72
echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 
echo 1612800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "19000 1382400:39000"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 95
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 20000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "60 883000:70 940000:75 1056000:80 "
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 40000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 0
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0
#Cpu-Boost
write /sys/module/cpu_boost/parameters/input_boost_enabled 1
write /sys/module/cpu_boost/parameters/input_boost_freq "0:691000 1:691000 2:691000 3:691000 4:0 5:0"
write /sys/module/cpu_boost/parameters/input_boost_ms 10
write /sys/module/msm_performance/parameters/touchboost 0
#Hotplug
write /sys/module/lazyplug/parameters/nr_run_profile_sel 4
write /sys/module/lazyplug/parameters/nr_run_hysteresis 6
write /sys/module/lazyplug/parameters/cpu_nr_run_threshold 500
#Workqueue
echo Y > /sys/module/workqueue/parameters/power_efficient 
#Scheduler
echo maple > /sys/block/mmcblk0/queue/scheduler
echo maple > /sys/block/mmcblk1/queue/scheduler
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
#echo 9887 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq 
echo 805 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq 
#echo 9887 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 
echo 0 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq
#Msm-Thermals
echo 45 > /sys/module/msm_thermal/parameters/temp_threshold 
echo 60 > /sys/module/msm_thermal/parameters/core_limit_temp_degC 
#Vmpressure
echo 100 > /proc/sys/vm/vfs_cache_pressure 
write /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk 0
