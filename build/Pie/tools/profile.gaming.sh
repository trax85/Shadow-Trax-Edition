#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}

#Cpu Governor And Frequencies Scaling Settings
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 1 > /sys/devices/system/cpu/cpu5/online
#A53
echo electroutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 500 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/up_rate_limit_us
echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/down_rate_limit_us
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/exp_util
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/iowait_boost_enable
#A72
echo electroutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo 500 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/up_rate_limit_us 
echo 10000 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/down_rate_limit_us
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/exp_util  
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/iowait_boost_enable
#Cpu-Boost
echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled 
echo 0:0 1:0 2:0 3:0 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 500 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 0 > /sys/module/cpu_boost/parameters/devfreq_input_boost
echo 50 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
#Frame-Boost
echo N > /sys/module/mdss_mdp/parameters/frame_boost
#Workqueue
echo N > /sys/module/workqueue/parameters/power_efficient
#Scheduler
echo deadline > /sys/block/mmcblk0/queue/scheduler
echo deadline > /sys/block/mmcblk1/queue/scheduler
#Adreno-Driver and Gpu
echo 3 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
echo N > /sys/module/adreno_idler/parameters/adreno_idler_active
echo 710000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
echo 600000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
echo 0 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
#Devfreq-Drivers
#echo 9887 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq
echo 1611 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq
#echo 9887 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 
echo 1611 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq
#Walt-Toggles
echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
echo 1 > /proc/sys/kernel/sched_use_walt_task_util
echo 1 > /proc/sys/kernel/sched_boost
#ScheduleTuning
echo -10 > /dev/stune/background/schedtune.boost
echo -10 > /dev/stune/foreground/schedtune.boost
echo 5 > /dev/stune/top-app/schedtune.boost
#Msm-Thermals
echo 90 > /sys/module/msm_thermal/parameters/temp_threshold
echo 90 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
#Vmpressure
echo 100 > /proc/sys/vm/vfs_cache_pressure
