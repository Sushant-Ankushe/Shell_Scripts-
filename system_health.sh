#!/bin/bash
#=============================================System health Checkup Script=============================
set -euo pipefail
#===================CPU Health CHeck ==============
core=$(nproc)
echo "===================================================================="
echo "System has ${core} cores"
load=$(awk '{print $1}' /proc/loadavg)
if awk -v l="$load" -v c="$core" 'BEGIN { exit !(l/c > 0.7)}';then
	echo "CPU is busy load:${load} on cores:${core}"
else
	echo "CPU is Healthy"
fi
#====================Memory Health================
echo "===================================================================="
totalspace=$(free | tail -n +2 | head -1 | awk '{print $2}' | sed 's/Gi//g')
availablespace=$(free | tail -n +2 | head -1 | awk '{print $7}' | sed 's/Gi//g')
perc=$((100*availablespace/totalspace))
echo "Total Memory used is : $perc%"
if [ $perc -gt 80 ];then
	echo "Warning Memory usage exceeds 80%"
fi
echo "===================================================================="
#=====================Disk Health(On root)==========

used=$(df -h / | awk '{print$5}' | tail -1 | sed 's/%//g')
echo "Diske usage of root is $used%"
if [ $used -gt 80 ];then
	echo "Warning Disk usage of root is more than 80%"
fi
echo "===================================================================="
