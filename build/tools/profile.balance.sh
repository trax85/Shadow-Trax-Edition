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
#Core-A53
echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 1000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
echo 1000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/io_wait_boost
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/exp_util
#Core-A72 
echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1612800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo 3200 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
echo 1000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/io_wait_boost
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/exp_util
#Cpu-Boost
echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
echo 0:0 1:0 2:0 3:0 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
echo 1000 > /sys/module/cpu_boost/parameters/input_boost_ms
echo 1 > /sys/module/cpu_boost/parameters/input_devfreq_boost
echo 50 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
#Frame-Boost
echo Y > /sys/module/mdss_mdp/parameters/frame_boost
#Workqueue
echo Y > /sys/module/workqueue/parameters/power_efficient
#Scheduler
echo zen > /sys/block/mmcblk0/queue/scheduler
echo zen > /sys/block/mmcblk1/queue/scheduler
#Adreno-Idler-Driver
echo Y > /sys/module/adreno_idler/parameters/adreno_idler_active
echo 80 > /sys/module/adreno_idler/parameters/adreno_idler_downdifferential
echo 10 > /sys/module/adreno_idler/parameters/adreno_idler_idlewait
echo 8000 > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload
#GPU-Toggles
echo msm-adreno-tz > /sys/class/kgsl/kgsl-3d0/devfreq/governor
echo 1 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
echo 550000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
echo 550000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
echo 200000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 
echo 4 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
echo 8 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
echo 5 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel
#MMC-HOST
echo 1 > /sys/class/mmc_host/mmc0/clk_scaling/scale_down_in_low_wr_load
echo 1 > /sys/class/mmc_host/mmc1/clk_scaling/scale_down_in_low_wr_load
#DDR-Bus
echo 0 > /sys/class/devfreq/gpubw/min_freq
echo 805 > /sys/class/devfreq/cpubw/min_freq
echo 805 > /sys/class/devfreq/mincpubw/min_freq
echo 307200 > /sys/class/devfreq/qcom,cci.49/min_freq
#Walt-Toggles
echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
echo 1 > /proc/sys/kernel/sched_use_walt_task_util
#ScheduleTuning
echo -10 > /dev/stune/background/schedtune.boost
echo 0 > /dev/stune/foreground/schedtune.boost
echo 0 > /dev/stune/top-app/schedtune.boost
echo 0 > /dev/stune/top-app/schedtune.prefer_idle
echo 1 > /dev/stune/background/schedtune.prefer_idle
echo 1 > /dev/stune/foreground/schedtune.prefer_idle
#Msm-Thermals
echo 45 > /sys/module/msm_thermal/parameters/temp_threshold
echo 60 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
#Vmpressure
echo 100 > /proc/sys/vm/vfs_cache_pressure
