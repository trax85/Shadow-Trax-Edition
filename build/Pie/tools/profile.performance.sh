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
echo blu_schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 820 > /sys/devices/system/cpu/cpu0/cpufreq/blu_schedutil/up_rate_limit_us
echo 2000 > /sys/devices/system/cpu/cpu0/cpufreq/blu_schedutil/down_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/blu_schedutil/iowait_boost_enable
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/exp_util
#A72
echo blu_schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 672000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo 890 > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/up_rate_limit_us
echo 1100 > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/down_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/iowait_boost_enable
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/blu_schedutil/exp_util
#Cpu-Boost
echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
echo 0:0 1:0 2:0 3:0 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 250 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 1 > /sys/module/cpu_boost/parameters/devfreq_input_boost
echo 40 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
#Frame-Boost
echo Y > /sys/module/mdss_mdp/parameters/frame_boost
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
#echo 9887 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq
echo 805 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq
#echo 9887 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq
echo 805 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq
#Walt-Toggles
echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
echo 1 > /proc/sys/kernel/sched_use_walt_task_util
#ScheduleTuning
echo -10 > /dev/stune/background/schedtune.boost
echo 50 > /dev/stune/top-app/schedtune.boost
#Msm-Thermals
echo 50 > /sys/module/msm_thermal/parameters/temp_threshold
echo 60 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
#Vmpressure
echo 90 > /proc/sys/vm/vfs_cache_pressure
