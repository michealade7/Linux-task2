#!/bin/bash
# Forensic Linux Log Analysis & User Access Control
# Ordered command reference — NOT an unattended automation script.
# Follow the workflow and execute commands in the appropriate account context.

# ============================================================
# PART 1 — NEW USER SETUP
# Run from an account authorized to use sudo.
# ============================================================

sudo useradd -m -s /bin/bash -G sudo forensic01

# Manual: set the forensic01 password.
sudo passwd forensic01

# Verify the account and sudo membership.
id forensic01

# ============================================================
# SWITCH TO forensic01
# Manual user switch.
# ============================================================

su - forensic01

whoami
pwd

# ============================================================
# CREATE LOG DIRECTORY
# Run as forensic01.
# ============================================================

mkdir -p /home/forensic01/logs
cd /home/forensic01/logs

pwd
ls -la

# ============================================================
# CREATE MOCK LOG — CAT
# At least 20 lines with timestamps and required keywords.
# ============================================================

cat > sys_events.log <<'EOF'
2026-10-01 08:00:01 INFO system startup completed
2026-10-01 08:05:12 INFO user01 logged into the system
2026-10-01 08:10:45 WARNING high memory usage detected
2026-10-01 08:15:22 ERROR failed authentication attempt for user01
2026-10-01 08:20:31 INFO root performed system maintenance
2026-10-01 08:25:17 INFO backup process started
2026-10-01 08:30:44 ERROR database connection failed
2026-10-01 08:35:09 WARNING disk space is running low
2026-10-01 08:40:55 INFO user01 accessed the logs directory
2026-10-01 08:45:33 ERROR unauthorized access attempt detected
2026-10-01 08:50:11 INFO root updated system configuration
2026-10-01 08:55:27 WARNING unusual network traffic detected
2026-10-01 09:00:42 INFO security monitoring service started
2026-10-01 09:05:18 ERROR service failed to start
2026-10-01 09:10:36 INFO user01 logged out
2026-10-01 09:15:24 WARNING multiple login attempts detected
2026-10-01 09:20:49 INFO root reviewed security logs
2026-10-01 09:25:15 ERROR file access denied
2026-10-01 09:30:28 INFO system health check completed
2026-10-01 09:35:51 WARNING temporary network interruption
EOF

# Demonstrate echo as required.
echo "2026-10-01 09:40:00 INFO additional event recorded" >> sys_events.log

# Verify line count and contents.
wc -l sys_events.log
cat sys_events.log

# ============================================================
# PART 2 — LOG FILTERING
# ============================================================

grep "ERROR" sys_events.log

grep -E "root|user01" sys_events.log

# Pipe ERROR results to less. Press q to exit.
grep "ERROR" sys_events.log | less

# Save ERROR results.
grep "ERROR" sys_events.log > error_report.txt

# Verify saved report.
cat error_report.txt

# Show first and last five lines.
head -n 5 sys_events.log
tail -n 5 sys_events.log

# View the full log.
cat sys_events.log

# ============================================================
# PART 3 — PERMISSIONS AND OWNERSHIP
# Run as forensic01 unless sudo is explicitly shown.
# ============================================================

echo "This file contains confidential forensic information." > confidential.txt

# Owner read/write; group and others have no access.
chmod 600 confidential.txt

# Verify permissions.
ls -l confidential.txt

# Change ownership to root.
sudo chown root:root confidential.txt

# Verify ownership and permissions.
ls -l confidential.txt

# IMPORTANT: Do NOT use sudo for the following access test.
# The purpose is to observe forensic01's access after ownership changes.
cat confidential.txt

# Manual editing/access test.
nano confidential.txt

# ============================================================
# PART 4 — TEMPORARY USERS
# Run from an account authorized to use sudo.
# ============================================================

sudo useradd -m guest1
sudo useradd -m guest2

# Set passwords if required.
sudo passwd guest1
sudo passwd guest2

# Add guest1 to sudo.
sudo usermod -aG sudo guest1

# Verify.
id guest1

# Delete guest2 including home directory.
sudo userdel -r guest2

# Verify removal.
id guest2
