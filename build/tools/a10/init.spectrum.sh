#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

# helper functions to allow Android init like script
function write() {
    echo -n $2 > $1
}

value=$(getprop persist.spectrum.profile)

# Set profile
if [[ $(getprop sys.boot_completed) -eq 1 ]]; then

    chmod 0644 /sys/class/kgsl/kgsl-3d0/max_gpuclk
    chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
    chmod 0644 /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    chmod 0644 /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq
    chmod 0644 /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq
    chmod 0644 /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq
    chmod 0644 /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 
    write /dev/cpuset/audio-app/cpus 0-2
    write /dev/cpuset/system-background/cpus 0-5
    write /dev/cpuset/camera-daemon/cpus 0-5
    write /sys/module/mdss_mdp/parameters/frame_boost n
    write /sys/module/msm_thermal/parameters/enabled y

    if [[ $value -eq 0 ]]; then
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
	echo 3000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
	echo 1000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/io_wait_boost
	echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/exp_util
	#Cpu-Boost
	echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0:0 1:0 2:0 3:0 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 1000 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo 1 > /sys/module/cpu_boost/parameters/input_devfreq_boost
	echo 0 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
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
	echo 0 > /dev/stune/background/schedtune.boost
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

    elif [[ $value -eq 1 ]]; then
    	#Cpu Governor And Frequencies Scaling Settings
	echo 1 > /sys/devices/system/cpu/cpu3/online
	echo 1 > /sys/devices/system/cpu/cpu5/online
	#Core-A53
	echo schedutil > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 100 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/up_rate_limit_us
	echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/down_rate_limit_us
	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/iowait_boost_enable
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/exp_util
	#Core-A72
	echo schedutil > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo 672000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 100 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/up_rate_limit_us
	echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/electroutil/down_rate_limit_us
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/iowait_boost_enable
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/electroutil/exp_util
	#Cpu-Boost
	echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0:1401600 1:1401600 2:1401600 3:1401600 4:1804800 5:1804800 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 2500 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo 1 > /sys/module/cpu_boost/parameters/input_devfreq_boost
	echo 0 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	#Frame-Boost
	echo Y > /sys/module/mdss_mdp/parameters/frame_boost
	#Workqueue
	echo N > /sys/module/workqueue/parameters/power_efficient
	#Scheduler
	echo deadline > /sys/block/mmcblk0/queue/scheduler
	echo deadline > /sys/block/mmcblk1/queue/scheduler
	#Adreno-Idler-Driver
	echo N > /sys/module/adreno_idler/parameters/adreno_idler_active
	#GPU-Toggles	
	echo msm-adreno-tz > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 2 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 266666667 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 2 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
	echo 4 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
	echo 3 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel
	#MMC-HOST
	echo 1 > /sys/class/mmc_host/mmc0/clk_scaling/scale_down_in_low_wr_load
	echo 1 > /sys/class/mmc_host/mmc1/clk_scaling/scale_down_in_low_wr_load
	#DDR-Bus
	echo 805 > /sys/class/devfreq/gpubw/min_freq
	echo 805 > /sys/class/devfreq/cpubw/min_freq
	echo 805 > /sys/class/devfreq/mincpubw/min_freq
	echo 307200 > /sys/class/devfreq/qcom,cci.49/min_freq
	#Walt-Toggles
	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	#ScheduleTuning
	echo -5 > /dev/stune/background/schedtune.boost
	echo 1 > /dev/stune/foreground/schedtune.boost
	echo 1 > /dev/stune/top-app/schedtune.boost
	echo 0 > /dev/stune/top-app/schedtune.prefer_idle
	echo 1 > /dev/stune/background/schedtune.prefer_idle
	echo 0 > /dev/stune/foreground/schedtune.prefer_idle
	#Msm-Thermals
	echo 60 > /sys/module/msm_thermal/parameters/temp_threshold
	echo 65 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
	#Vmpressure
	echo 100 > /proc/sys/vm/vfs_cache_pressure

    elif [[ $value -eq 2 ]]; then
    	#Cpu Governor And Frequencies Scaling Settings
	echo 0 > /sys/devices/system/cpu/cpu3/online
	echo 0 > /sys/devices/system/cpu/cpu5/online
	#Core-A53
	echo pwrutilx > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 400000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1382400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 990 > /sys/devices/system/cpu/cpu0/cpufreq/pwrutilx/up_rate_limit_us
	echo 1000 > /sys/devices/system/cpu/cpu0/cpufreq/pwrutilx/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/pwrutilx/iowait_boost_enable
	#Core-A72
	echo pwrutilx > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 1000 > /sys/devices/system/cpu/cpu4/cpufreq/pwrutilx/up_rate_limit_us
	echo 1000 > /sys/devices/system/cpu/cpu4/cpufreq/pwrutilx/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/pwrutilx/iowait_boost_enable
	#Cpu-Boost
	echo 0 > /sys/module/cpu_boost/parameters/input_boost_enabled
	echo 0:0 1:0 2:0 3:0 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo 0 > /sys/module/cpu_boost/parameters/input_devfreq_boost
	echo 0 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	#Frame-Boost
	echo N > /sys/module/mdss_mdp/parameters/frame_boost
	#Workqueue
	echo Y > /sys/module/workqueue/parameters/power_efficient
	#Scheduler
	echo noop > /sys/block/mmcblk0/queue/scheduler
	echo noop > /sys/block/mmcblk1/queue/scheduler 
	#Adreno-Idler-Driver
	echo Y > /sys/module/adreno_idler/parameters/adreno_idler_active
	echo 90 > /sys/module/adreno_idler/parameters/adreno_idler_downdifferential
	echo 4 > /sys/module/adreno_idler/parameters/adreno_idler_idlewait
	echo 9000 > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload
	#GPU-Toggles
	echo msm-adreno-tz > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 0 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
	echo 550000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
	echo 550000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 200000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 4 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
	echo 9 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
	echo 8 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel
	#MMC-HOST
	echo 0 > /sys/class/mmc_host/mmc0/clk_scaling/scale_down_in_low_wr_load
	echo 0 > /sys/class/mmc_host/mmc1/clk_scaling/scale_down_in_low_wr_load
	#DDR-Bus
	echo 0 > /sys/class/devfreq/gpubw/min_freq
	echo 805 > /sys/class/devfreq/cpubw/min_freq
	echo 805 > /sys/class/devfreq/mincpubw/min_freq
	echo 307200 > /sys/class/devfreq/qcom,cci.49/min_freq
	#Walt-Toggles
	echo 0 > /proc/sys/kernel/sched_use_walt_cpu_util
	echo 0 > /proc/sys/kernel/sched_use_walt_task_util
	#ScheduleTuning
	echo -5 > /dev/stune/background/schedtune.boost
	echo -5 > /dev/stune/foreground/schedtune.boost
	echo 0 > /dev/stune/top-app/schedtune.boost
	echo 1 > /dev/stune/top-app/schedtune.prefer_idle
	echo 1 > /dev/stune/background/schedtune.prefer_idle
	echo 1 > /dev/stune/foreground/schedtune.prefer_idle
	#Msm-Thermals
	echo 45 > /sys/module/msm_thermal/parameters/temp_threshold
	echo 60 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
	#Vmpressure
	echo 60 > /proc/sys/vm/vfs_cache_pressure

    else [[ $value -eq 3 ]];

    	#Cpu Governor And Frequencies Scaling Settings
	echo 1 > /sys/devices/system/cpu/cpu3/online
	echo 1 > /sys/devices/system/cpu/cpu5/online
	#Core-A53
	echo performance > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	#Core-A72
	echo performance > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	#Cpu-Boost
	echo 1 > /sys/module/cpu_boost/parameters/input_boost_enabled 
	echo 0:0 1:0 2:0 3:0 4:0 5:0 > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 1500 > /sys/module/cpu_boost/parameters/input_boost_ms
	echo 1 > /sys/module/cpu_boost/parameters/input_devfreq_boost
	echo 0 > /sys/module/cpu_boost/parameters/dynamic_stune_boost
	#Frame-Boost
	echo Y > /sys/module/mdss_mdp/parameters/frame_boost
	#Workqueue
	echo N > /sys/module/workqueue/parameters/power_efficient
	#Scheduler
	echo deadline > /sys/block/mmcblk0/queue/scheduler
	echo deadline > /sys/block/mmcblk1/queue/scheduler
	#Adreno-Idler-Driver
	echo N > /sys/module/adreno_idler/parameters/adreno_idler_active
	#GPU-Toggles	
	echo msm-adreno-tz > /sys/class/kgsl/kgsl-3d0/devfreq/governor
	echo 3 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk
	echo 710000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
	echo 480000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq
	echo 0 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
	echo 1 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/min_pwrlevel
	echo 1 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/default_pwrlevel
	#MMC-HOST
	echo 1 > /sys/class/mmc_host/mmc0/clk_scaling/scale_down_in_low_wr_load
	echo 1 > /sys/class/mmc_host/mmc1/clk_scaling/scale_down_in_low_wr_load
	#DDR-Bus
	echo 7104 > /sys/class/devfreq/gpubw/min_freq
	echo 1244 > /sys/class/devfreq/cpubw/min_freq
	echo 1244 > /sys/class/devfreq/mincpubw/min_freq
	echo 307200 > /sys/class/devfreq/qcom,cci.49/min_freq
	#Walt-Toggles
	echo 1 > /proc/sys/kernel/sched_use_walt_cpu_util
	echo 1 > /proc/sys/kernel/sched_use_walt_task_util
	#ScheduleTuning
	echo -5 > /dev/stune/background/schedtune.boost
	echo 1 > /dev/stune/foreground/schedtune.boost
	echo 10 > /dev/stune/top-app/schedtune.boost
	echo 0 > /dev/stune/top-app/schedtune.prefer_idle
	echo 0 > /dev/stune/background/schedtune.prefer_idle
	echo 0 > /dev/stune/foreground/schedtune.prefer_idle
	#Msm-Thermals
	echo 100 > /sys/module/msm_thermal/parameters/temp_threshold
	echo 100 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
	#Vmpressure
	echo 100 > /proc/sys/vm/vfs_cache_pressure
    fi   
fi
