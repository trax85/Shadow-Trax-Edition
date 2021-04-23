#!/sbin/sh
 #
 # Type any shell commands here
 #
 # They will execute on every boot
 #
 # Lines starting with # are just comments
 #
 # Enjoy !
 #
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}
    #Set Low memory killer minfree parameters
    # 64 bit up to 2GB with use 14K, and above 2GB will use 18K
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # 64 bit will have 81K 
    chmod 0660 /sys/module/lowmemorykiller/parameters/minfree

    if [ $MemTotal -gt 2000000 ]; then
        echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
    else
        echo "16384,20992,24064,30720,46080,66560" > /sys/module/lowmemorykiller/parameters/minfree
	echo 10 > /proc/sys/vm/dirty_background_ratio
	echo 0 > /sys/module/lowmemorykiller/parameters/lmk_fast_run
    fi
    sleep 5
    echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
    echo 1 > /sys/devices/virtual/block/zram0/reset
    echo 0 > /sys/block/zram0/disksize
    swapoff /dev/block/zram0
    echo 1 > /dev/stune/top-app/schedtune.boost
    
