# Linux Server Health Check Script

A Bash script to monitor the basic health of a Linux server by checking CPU load, memory availability, and root filesystem disk usage. It generates a health report with a timestamp and an overall server status.

## Features

- **CPU Health Check:** Monitors the 1-minute system load average and compares it against 70% of the available CPU core count.
- **Memory Health Check:** Calculates available memory as a percentage of total memory and flags the system if available memory exceeds 80%.
- **Root Disk Health Check:** Monitors root filesystem (`/`) disk usage and flags it when usage exceeds 80%.
- **Overall Health Status:** Reports `Healthy` if all checks pass; otherwise, reports `Unhealthy`.
- **Timestamped Report:** Displays the date and time when the health check runs.

## Prerequisites

- A Linux system
- Bash shell
- Standard Linux utilities: `awk`, `free`, `df`, `nproc`, `sed`, and `date`

## Installation

Clone the repository:

git clone <YOUR_REPOSITORY_URL>
cd <YOUR_REPOSITORY_DIRECTORY>

Make the script executable:

chmod +x health_check.sh

## Usage

Run the script:

./health_check.sh

If required, run it through Bash:

bash health_check.sh

## Sample Output

====================================================================
                Linux Server Health Report
====================================================================
Timestamp       : Fri Oct 16 15:00:00 IST 2026
CPU Load (1m)   : 0.35 [Ok]
Memory Usage    : 45% [Ok]
Root Disk Usage : 62% [Ok]
Overall status  : Healthy
====================================================================

*Note: The sample output is illustrative. Actual values depend on your system's current resource usage.*

## Health Check Logic

| Component | Condition | Result |
|---|---|---|
| CPU load | Load average / CPU cores > 0.7 | Not OK |
| Memory | Available memory > 80% of total | Not OK |
| Root disk | Usage > 80% | Not OK |
| Overall status | All checks pass | Healthy |
| Overall status | Any check fails | Unhealthy |

## Error Handling

The script uses:
set -euo pipefail

This enables stricter Bash behavior by exiting on many command failures, treating unset variables as errors, and propagating failures through pipelines.

## Future Improvements

- Add configurable warning thresholds.
- Send alerts through email or messaging services.
- Log reports to a file for historical monitoring.
- Add checks for swap usage, running services, and network connectivity.
- Support command-line arguments for custom thresholds.
- Add automated tests for health-check conditions.

## Learning Objectives

This project demonstrates practical Linux administration and Bash scripting concepts, including:

- Variables and command substitution
- Conditional statements and arithmetic
- Text processing with `awk` and `sed`
- System monitoring using `/proc`, `free`, and `df`
- Exit status handling and strict Bash options
- Generating a formatted system health report
