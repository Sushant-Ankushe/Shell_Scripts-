#!/bin/bash
set -euo pipefail
logdir=${1:-/var/log/myapp}
retention=${2:-7}
deletecount=0
zippedcount=0
logmessage() {
	echo "========================================"
	echo "files $1 $2"
	echo "========================================"
}
logrotater() {
if [ ! -d "$logdir" ];then
	echo "There is no log dir"
	exit 1
else
	diskusagebefore=$(du -sh "$logdir" | awk '{print $1}')
	while IFS= read -r file1;do
        rm -f "$file1"
	deletecount=$((deletecount+1))
done< <(find "$logdir" -type f -name "*.log.gz" -mtime +"$retention") 

	logmessage "deleted" "$deletecount"

	while IFS= read -r file;do
	if [ -f "$file.gz" ];then
		echo "$file is already zipped"
	else
		gzip "$file"
		zippedcount=$((zippedcount+1))

	fi
	
done < <(find "$logdir" -type f -name "*.log" -mmin +1440)

		logmessage "zipped" "$zippedcount"

fi
echo "$diskusagebefore"
diskusageafter=$(du -sh /var/log/myapp | awk '{print $1}')
echo "$diskusageafter"


}




logrotater $logdir $retention
