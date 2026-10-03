#!/bin/bash
set -euo pipefail
if [[ $# -gt 0 ]]; then
    services=("$@")
else
    services=("nginx" "docker" "cron")
fi
active="0"
restarted="0"
failed="0"
for item in "${services[@]}";do
	status=$(sudo systemctl is-active "$item")
if [ "$status" == "active" ];then
	echo "${item} is active"
	active=$((active+1))
elif [ "$status" == "inactive" ];then
	echo "${item} is inactive trying to restart"
	sudo systemctl restart "$item"
	sleep 10
	#restarted=$((restarted+1))
	status2=$(sudo systemctl is-active "$item")
	if [ "$status" == "active" ];then
		echo "${item} is restarted"
		restarted=$((restarted+1))
	elif [ "$status" == "inactive" ];then
		echo "${item} failed to restart"
		failed=$((failed+1))
	fi
fi


done

logmessage() {
echo "===========Summary=============="
echo "Total services active: ${active}"
echo "Total services restarted: ${restarted}"
echo "Total services failed to restart: ${failed}"

}
logmessage "$active" "$restarted" "$failed"
