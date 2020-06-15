#!/system/bin/sh
# SPECTRUM & FRANCO KERNEL MANAGERS
# Profile initialization by Zile995

#A53
echo cultivation > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/go_hispeed_load 99
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/above_hispeed_delay 30000
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/hispeed_freq 1305600
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/min_sample_time 45000
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/timer_rate 40000
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/max_freq_hysteresis 0
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/timer_slack -1
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/powersave_bias 1
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/fastlane 0
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/align_windows 1
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/target_loads "60 400000:25 691200:40 1017600:55 1190400:85 1305600:99"
write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/use_sched_load 0
#a72
echo cultivation > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
echo 400000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
echo 1305600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/go_hispeed_load 99
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/above_hispeed_delay 25000
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/hispeed_freq 0
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/min_sample_time 30000
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/timer_rate 25000
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/max_freq_hysteresis 0
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/timer_slack -1
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/powersave_bias 1
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/fastlane 0
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/align_windows 1
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/target_loads "90"
write /sys/devices/system/cpu/cpu4/cpufreq/cultivation/use_sched_load 0
#Cpu-Boost
write /sys/module/cpu_boost/parameters/input_boost_enabled 0
write /sys/module/cpu_boost/parameters/input_boost_freq "0:0 1:0 2:0 3:0 4:0 5:0"
write /sys/module/cpu_boost/parameters/input_boost_ms 0
write /sys/module/msm_performance/parameters/touchboost 0
#Hotplug
write /sys/module/lazyplug/parameters/lazyplug_active 1
write /sys/module/lazyplug/parameters/nr_run_profile_sel 6
write /sys/module/lazyplug/parameters/nr_run_hysteresis 6
write /sys/module/lazyplug/parameters/cpu_nr_run_threshold 500
#Workqueue
echo Y > /sys/module/workqueue/parameters/power_efficient 
#Scheduler
echo noop > /sys/block/mmcblk0/queue/scheduler
echo noop > /sys/block/mmcblk1/queue/scheduler 
#Adreno-Driver and Gpu
echo 0 > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 
echo N > /sys/module/adreno_idler/parameters/adreno_idler_active 
echo 90 > /sys/module/adreno_idler/parameters/adreno_idler_downdiffrential 
echo 4 > /sys/module/adreno_idler/parameters/adreno_idler_idlewait 
echo 9000 > /sys/module/adreno_idler/parameters/adreno_idler_idleworkload 
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
echo 60 > /proc/sys/vm/vfs_cache_pressure 
