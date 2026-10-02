# Shell_Scripts-
This is the repository where I will create day today useful shell scripts.
=============================disk_alert.sh==============
Checks disk usage for all mounted filesystems.
Prints a WARNING for any filesystem above 80% usage and a CRITICAL for any above 90%.
Writes the alerts with a timestamp to /tmp/disk_alert.log (the real-world version would email or post to Slack).
Exits with code 0 if everything is fine, 1 if there's a warning, and 2 if there's a critical alert.

=============================log_cleanup.sh====================
Takes the log directory as the first argument (default /var/log/myapp) and a retention period in days as the second (default 7).
Exits with an error message if the directory doesn't exist.
Compresses (gzip) any .log file older than 1 day that isn't already compressed.
Deletes any .log.gz file older than the retention period.
Prints a summary at the end: number of files compressed, number deleted, and total disk space freed (approximate is fine).
Logs each action with a timestamp to /tmp/log_cleanup.log.
================================service_watchdog.sh=============
Accepts a list of service names as arguments (default: nginx docker cron).
For each service, checks whether it is active (use systemctl is-active).
If a service is down, attempts to restart it once, waits a few seconds, and re-checks.
Logs every outcome with a timestamp to /tmp/service_watchdog.log, using one of these states: OK, RESTARTED, FAILED.
Prints a summary at the end: how many services were OK, restarted, and failed.
Exits with 0 if all services are OK or were successfully restarted, 1 if any service could not be recovered.
