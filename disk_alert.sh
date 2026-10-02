#!/bin/bash
set -euo pipefail
timestamp=$(date)
status="0"
while read -r file;do
usage=$(echo "$file"| sed 's/%//g'| awk '{print$5}')
filesystem=$(echo "$file"| awk '{print$1}')
#echo "$filesystem" 
if [ $usage -gt 90 ];then
       #echo "$filesystem - CRITICAL"	
       echo "${timestamp} Critical ${filesystem} usage is ${usage}" >> /tmp/disk_alert.log
       status=2       



elif [ $usage -gt 80 ];then
       echo ${timestamp} "WARNING ${filesystem} usage is ${usage}" >> /tmp/disk_alert.log
       status=1
              

fi

done < <(df -h | tail -n +2)
exit "$status"

