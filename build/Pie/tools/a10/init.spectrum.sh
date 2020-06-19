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
	#A53
	echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 
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
	echo 672000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 
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
	write /sys/module/cpu_boost/parameters/input_boost_enabled 0
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

    elif [[ $value -eq 1 ]]; then
    	#Cpu Governor And Frequencies Scaling Settings
	#A53
	echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay "25000"
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 90
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1401600
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "40 960000:50 1017600:60 1190400:70 	1305600:80 1401600:90"
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 45000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 45000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1
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
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 1
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 1
	#Cpu-Boost
	write /sys/module/cpu_boost/parameters/boost_ms 250
	write /sys/module/cpu_boost/parameters/input_boost_enabled 1
	write /sys/module/cpu_boost/parameters/input_boost_freq "0:1017600 1:1017600 2:1017600 3:1017600 		4:1190400 5:1190400"
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
	#echo 9887 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq
	echo 805 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq
	#echo 9887 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq
	echo 805 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq
	#Msm-Thermals
	echo 50 > /sys/module/msm_thermal/parameters/temp_threshold
	echo 75 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
	#Vmpressure
	echo 100 > /proc/sys/vm/vfs_cache_pressure

    elif [[ $value -eq 2 ]]; then
    	#Cpu Governor And Frequencies Scaling Settings
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
	write /sys/devices/system/cpu/cpu0/cpufreq/cultivation/target_loads "60 400000:25 691200:40 1017600:55 		1190400:85 1305600:99"
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

    else [[ $value -eq 3 ]];
    	#Cpu Governor And Frequencies Scaling Settings
	#A53
	echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 75
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 25000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 1401600
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 20000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 20000
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/boost 0
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "80 960000:30 1017600:40 1190400:50 	1305600:60 1401600:75"
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load 1
	write /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif 1
	#A72
	echo interactive > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo 883200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 
		echo 1804800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 50
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/boost 0
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "15000 1382400:25000"
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1804800
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 20000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "50 1190400:35 1382400:50 1612800:60 	 1747200:70 1804800:75"
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 45000
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif 1
	write /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load 1
	#Cpu-Boost
	write /sys/module/cpu_boost/parameters/input_boost_enabled 1
	write /sys/module/cpu_boost/parameters/input_boost_freq "0:1305600 1:1305600 2:1305600 3:1305600 		4:1190400 5:1190400"
	write /sys/module/cpu_boost/parameters/input_boost_ms 500
	#Hotplug
	write /sys/module/lazyplug/parameters/lazyplug_active 0
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
	echo 480000000 > /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 
	echo 0 > /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 
	#Devfreq-Drivers
	#echo 9887 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq 
	echo 805 > /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq 
	#echo 9887 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 
	echo 805 > /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 
	#Msm-Thermals
	echo 90 > /sys/module/msm_thermal/parameters/temp_threshold 
	echo 90 > /sys/module/msm_thermal/parameters/core_limit_temp_degC 
	#Vmpressure
	echo 75 > /proc/sys/vm/vfs_cache_pressure 
    fi   
fi
