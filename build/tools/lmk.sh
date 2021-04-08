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
 echo '14474,21711,43422,72370,101318,108555' > /sys/module/lowmemorykiller/parameters/minfree
 echo 1 > /dev/stune/top-app/schedtune.boost
