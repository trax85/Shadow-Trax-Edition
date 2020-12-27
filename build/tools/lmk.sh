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
 chmod 0644 /sys/module/lowmemorykiller/parameters/minfree
 echo '16969,22624,28280,33936,39592,50904' > /sys/module/lowmemorykiller/parameters/minfree
 echo 1 > /dev/stune/top-app/schedtune.boost
