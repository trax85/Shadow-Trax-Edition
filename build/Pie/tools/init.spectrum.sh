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

    chmod 0644 /sys/module/workqueue/parameters/power_efficient
    chmod 0644 /sys/class/kgsl/kgsl-3d0/max_gpuclk
    chmod 0644 /sys/class/kgsl/kgsl-3d0/devfreq/max_freq
    chmod 0664 /sys/class/kgsl/kgsl-3d0/devfreq/governor
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    chmod 0644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    chmod 0644 /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/governor bw_hwmon
    chmod 0644 /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq
    chmod 0644 /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq
    chmod 0644 /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/polling_interval
    chmod 0644 /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq
    chmod 0644 /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 
    chmod 0644 /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/polling_interval
    chmod 0644 /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/max_freq 
    chmod 0644 /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/min_freq 
    chmod 0644 /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/polling_interval 

    echo "msm-adreno-tz" > /sys/class/kgsl/kgsl-3d0/devfreq/governor

    if [[ $value -eq 0 ]]; then
        echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 691200
        write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1401600
        write /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us 500
	write /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us 1000
	write /sys/devices/system/cpu/cpu0/cpufreq/schedutil/iowait_boost_enable 0
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 883000
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1612000
        write /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us 650
	write /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us 1000
	write /sys/devices/system/cpu/cpu4/cpufreq/schedutil/iowait_boost_enable 0
        write /sys/module/cpu_boost/parameters/input_boost_enabled 0
        write /sys/module/cpu_boost/parameters/input_boost_freq "0:691200 1:2:691200 3:691200 4:691200 4:883200 5:883200"
        write /sys/module/cpu_boost/parameters/input_boost_ms 10
        write /sys/module/cpu_boost/parameters/input_devfreq_boost 1
        write /sys/block/mmcblk0/queue/scheduler deadline
        write /sys/block/mmcblk1/queue/scheduler deadline
        write /sys/module/adreno_idler/parameters/adreno_idler_active Y
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 623330000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 623330000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 266666667
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 5
        write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 5
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq 5859
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq 805
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/polling_interval 100
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 5859
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 805
        write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/polling_interval 80
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/max_freq 5859
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/min_freq 805
        write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/polling_interval 60
        write /sys/module/msm_thermal/parameters/temp_threshold 45
        write /sys/module/msm_thermal/parameters/core_limit_temp_degC 60
    	write /proc/sys/vm/vfs_cache_pressure 100

    elif [[ $value -eq 1 ]]; then
    	echo "schedutil-stock" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "schedutil-stock" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    	write /sys/module/workqueue/parameters/power_efficient N
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 691200
        write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1440000
        write /sys/devices/system/cpu/cpu0/cpufreq/schedutil-stock/up_rate_limit_us 500
	write /sys/devices/system/cpu/cpu0/cpufreq/schedutil-stock/down_rate_limit_us 10000
	write /sys/devices/system/cpu/cpu0/cpufreq/schedutil-stock/iowait_boost_enable 1 
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 883000
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1843200
        write /sys/devices/system/cpu/cpu4/cpufreq/schedutil-stock/up_rate_limit_us 500
	write /sys/devices/system/cpu/cpu4/cpufreq/schedutil-stock/down_rate_limit_us 10000
	write /sys/devices/system/cpu/cpu4/cpufreq/schedutil-stock/iowait_boost_enable 1
    	write /sys/module/cpu_boost/parameters/input_boost_enabled 1
        write /sys/module/cpu_boost/parameters/input_boost_freq "0:1305600 1:1305600 2:1305600 3:1305600 4:1190400 5:1190400"
        write /sys/module/cpu_boost/parameters/input_boost_ms 500
        write /sys/module/cpu_boost/parameters/input_devfreq_boost 1
        write /sys/module/adreno_idler/parameters/adreno_idler_active N
        write /sys/block/mmcblk0/queue/scheduler deadline
        write /sys/block/mmcblk1/queue/scheduler deadline
        write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 2
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 710000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 710000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 266666667
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 3
        write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 3
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq 9887
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq 1611
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/polling_interval 40
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 9887
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 1611
        write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/polling_interval 40
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/max_freq 9887
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/min_freq 1611
        write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/polling_interval 40
        write /sys/module/msm_thermal/parameters/temp_threshold 45
        write /sys/module/msm_thermal/parameters/core_limit_temp_degC 60
    	write /proc/sys/vm/vfs_cache_pressure 100

    elif [[ $value -eq 2 ]]; then
    	echo "pwrutilx" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "pwrutilx" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    	write /sys/module/workqueue/parameters/power_efficient Y
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 400000
        write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1305600
	write /sys/devices/system/cpu/cpu0/cpufreq/pwrutilx/up_rate_limit_us 1000
	write /sys/devices/system/cpu/cpu0/cpufreq/pwrutilx/down_rate_limit_us 2500
	write /sys/devices/system/cpu/cpu0/cpufreq/pwrutilx/iowait_boost_enable 0
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 400000
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1305600
	write /sys/devices/system/cpu/cpu4/cpufreq/pwrutilx/up_rate_limit_us 2000
	write /sys/devices/system/cpu/cpu4/cpufreq/pwrutilx/down_rate_limit_us 2000
	write /sys/devices/system/cpu/cpu4/cpufreq/pwrutilx/iowait_boost_enable 0
    	write /sys/module/cpu_boost/parameters/input_boost_enabled 0
        write /sys/module/cpu_boost/parameters/input_boost_freq "0:0 1:0 2:0 3:0 4:0 5:0"
        write /sys/module/cpu_boost/parameters/input_boost_ms 10
        write /sys/module/cpu_boost/parameters/input_devfreq_boost 0
        write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 0
        write /sys/module/adreno_idler/parameters/adreno_idler_active Y
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 550000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 550000000
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 266666667
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 7
        write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 6
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq 4135
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq 805
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/polling_interval 40
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 4135
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 805
        write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/polling_interval 40
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/max_freq 4135
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/min_freq 805
        write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/polling_interval 100
        write /sys/module/msm_thermal/parameters/temp_threshold 70
        write /sys/module/msm_thermal/parameters/core_limit_temp_degC 60
    	write /proc/sys/vm/vfs_cache_pressure 100

    else [[ $value -eq 3 ]];

    	echo "schedutil-stock" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "schedutil-stock" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    	write /sys/module/workqueue/parameters/power_efficient N
    	write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 691200
        write /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq 1440000
        write /sys/devices/system/cpu/cpu0/cpufreq/schedutil-stock/up_rate_limit_us 500
	write /sys/devices/system/cpu/cpu0/cpufreq/schedutil-stock/down_rate_limit_us 10000
	write /sys/devices/system/cpu/cpu0/cpufreq/schedutil-stock/iowait_boost_enable 1 
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq 998400
        write /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq 1843200
        write /sys/devices/system/cpu/cpu4/cpufreq/schedutil-stock/up_rate_limit_us 500
	write /sys/devices/system/cpu/cpu4/cpufreq/schedutil-stock/down_rate_limit_us 10000
	write /sys/devices/system/cpu/cpu4/cpufreq/schedutil-stock/iowait_boost_enable 1
        write /sys/module/cpu_boost/parameters/input_boost_enabled 1
        write /sys/module/cpu_boost/parameters/input_boost_freq "0:1305600 1:1305600 2:1305600 3:1305600 4:1612800 5:1612800"
        write /sys/module/cpu_boost/parameters/input_boost_ms 1500
        write /sys/module/cpu_boost/parameters/input_devfreq_boost 1
        write /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost 3
        write /sys/module/adreno_idler/parameters/adreno_idler_active N
    	write /sys/class/kgsl/kgsl-3d0/max_gpuclk 753333333
    	write /sys/class/kgsl/kgsl-3d0/devfreq/max_freq 753333333
    	write /sys/class/kgsl/kgsl-3d0/devfreq/min_freq 600000000
    	write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 3
        write /sys/block/mmcblk0/queue/scheduler deadline
        write /sys/block/mmcblk1/queue/scheduler deadline
        write /sys/class/kgsl/kgsl-3d0/default_pwrlevel 0
        write /sys/devices/soc.0/1c00000.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel 0
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/max_freq 11863
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/min_freq 5859
        write /sys/devices/soc.0/qcom,cpubw.50/devfreq/cpubw/polling_interval 50
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/max_freq 11863
    	write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/min_freq 4173
        write /sys/devices/soc.0/qcom,gpubw.36/devfreq/gpubw/polling_interval 50
        write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/max_freq 11863
    	write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/min_freq 4173
        write /sys/devices/soc.0/qcom,mincpubw.51/devfreq/mincpubw/polling_interval 50
        write /sys/module/msm_thermal/parameters/enabled y
        write /sys/module/msm_thermal/parameters/temp_threshold 90
        write /sys/module/msm_thermal/parameters/core_limit_temp_degC 90
    	write /proc/sys/vm/vfs_cache_pressure 75
    fi   
fi
