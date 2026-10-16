#!/bin/bash
#=============================================System health Checkup Script=============================
set -euo pipefail
#===================CPU Health CHeck ==============
core=$(nproc)
cpu="0"
disk="0"
root="0"
load=$(awk '{print $1}' /proc/loadavg)
if awk -v l="$load" -v c="$core" 'BEGIN { exit !(l/c > 0.7)}';then
	cpu="[Not OK]"
else
	cpu="[Ok]"
fi
#====================Memory Health================
totalspace=$(free | tail -n +2 | head -1 | awk '{print $2}' | sed 's/Gi//g')
availablespace=$(free | tail -n +2 | head -1 | awk '{print $7}' | sed 's/Gi//g')
perc=$((100*availablespace/totalspace))
if [ $perc -gt 80 ];then
	disk="[Not OK]"
else
	disk="[Ok]"
fi

#=====================Disk Health(On root)==========

used=$(df -h / | awk '{print$5}' | tail -1 | sed 's/%//g')
#echo "Diske usage of root is $used%"
if [ $used -gt 80 ];then
	#echo "Warning Disk usage of root is more than 80%"
	root="[Not Ok]"
else
	root="[Ok]"
fi

echo "===================================================================="
echo "		       Linux Server Health Report			  "
echo "===================================================================="
echo "Timestamp	:$(date)"
echo "CPU Load (1m)	:$load $cpu"
echo "Memory Usage	:$perc% $disk"
echo "Root Disk Usage	:$used% $root"
if [ "$cpu" = "[Ok]" ]  && [ "$disk" = "[Ok]" ] && [ "$root" = "[Ok]" ];then
	status="Healthy"
else
	status="Unhealthy"
fi
echo "Overall status	:$status"
echo "===================================================================="

