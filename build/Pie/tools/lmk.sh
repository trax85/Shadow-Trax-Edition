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
 sleep 3
 chmod 0660 /sys/module/lowmemorykiller/parameters/minfree
 echo '5645,11308,16962,22616,28270,33924' > /sys/module/lowmemorykiller/parameters/minfree
