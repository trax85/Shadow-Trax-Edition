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
echo cultivation > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 99 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/go_hispeed_load
echo 30000 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/above_hispeed_delay
echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/hispeed_freq
echo 45000 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/min_sample_time
echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/timer_rate 
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/max_freq_hysteresis
echo -1 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/timer_slack
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/powersave_bias
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/fastlane
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/align_windows
echo "60 400000:25 691200:40 1017600:55 1190400:85 1305600:99" > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/target_loads
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/cultivation/use_sched_load
#a72
echo cultivation > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1305600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo 691200 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/go_hispeed_load
echo 99 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/above_hispeed_delay 
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/hispeed_freq
echo 30000 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/min_sample_time
echo 25000 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/timer_rate 
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/max_freq_hysteresis
echo -1 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/timer_slack
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/powersave_bias
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/fastlane
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/align_windows
echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/target_loads 
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/cultivation/use_sched_load
#Cpu-Boost
echo 0 > /sys/module/cpu_boost/parameters/input_boost_enabled
echo "0:0 1:0 2:0 3:0 4:0 5:0" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 0 > /sys/module/cpu_boost/parameters/input_boost_ms
#Hotplug
echo 1 > /sys/module/lazyplug/parameters/lazyplug_active
echo 6 > /sys/module/lazyplug/parameters/nr_run_profile_sel
echo 6 > /sys/module/lazyplug/parameters/nr_run_hysteresis
echo 500 > /sys/module/lazyplug/parameters/cpu_nr_run_threshold
#Workqueue
echo Y > /sys/module/workqueue/parameters/power_efficient 
#Scheduler
echo noop > /sys/block/mmcblk0/queue/scheduler
echo noop > /sys/block/mmcblk1/queue/scheduler 
#Adreno-Driver and Gpu
echo 0 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 
echo Y > /sys/module/adreno_idler/parameters/adreno_idler_active 
echo 90 > /sys/module/adreno_idler/parameters/adreno_idler_downdiffrential 
echo 4 > /sys/module/adreno_idler/parameters/adreno_idler_idlewait 
echo 9000 > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload 
echo 550000000 > /sys/class/kgsl/kgsl-3d0/max_gpuclk 
echo 550000000 > /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 
echo 266666667 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 
echo 5 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 
#Devfreq-Drivers
echo 0 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 
#Msm-Thermals
echo 45 > /sys/module/msm_thermal/parameters/temp_threshold 
echo 60 > /sys/module/msm_thermal/parameters/core_limit_temp_degC 
#Vmpressure
echo 60 > /proc/sys/vm/vfs_cache_pressure 
