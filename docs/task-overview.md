# Task Overview

## Objective

Practice Linux user/account configuration, log analysis, permissions and ownership, and temporary user management.

## Requirement Map

| Area | Required outcome |
|---|---|
| User creation | `forensic01` with home directory, `/bin/bash`, `sudo` membership, password |
| User switch | Work as `forensic01` |
| Log workspace | `/home/forensic01/logs/` |
| Mock log | `sys_events.log`, at least 20 lines, timestamps and required keywords |
| Filtering | `grep "ERROR"` and `grep -E "root|user01"` |
| Piping | Pipe grep results to `less` |
| Redirection | Save ERROR results to `error_report.txt` |
| Line inspection | `head -n 5` and `tail -n 5` |
| Full log | `cat sys_events.log` |
| Confidential file | `confidential.txt` with owner read/write only |
| Ownership | Change owner to `root` with `sudo chown` |
| Access test | Attempt reading/editing as `forensic01` |
| Temporary users | Create `guest1` and `guest2` |
| User modification | Add `guest1` to `sudo` |
| User deletion | Remove `guest2` including home directory |
| Submission | Exact commands, screenshots, command explanations, access-learning explanation |
