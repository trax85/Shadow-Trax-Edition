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
    chmod 0644 /sys/module/lazyplug/parameters/lazyplug_active 
    write /sys/module/msm_thermal/parameters/enabled y
fi
