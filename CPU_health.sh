#!/bin/bash
#=============================================System health Checkup Script=============================
echo "Welcome to System Health Check"

#===================CPU Health CHeck =========================
core=$(nproc)
echo "System has ${core} cores"
load=$(awk '{print $1}' /proc/loadavg)
if awk -v l="$load" -v c="$core" 'BEGIN { exit !(l/c > 0.7)}';then
	echo "CPU is busy load:${load} on cores:${core}"
else
	echo "CPU is Healthy"
fi

 

