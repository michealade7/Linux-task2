# Forensic Linux Log Analysis & User Access Control

A GitHub-ready workflow for the Linux practical activity covering user setup, permissions and access control, log filtering and analysis, file ownership, and temporary user management.

## Objective

Complete the practical activity using Kali Linux/Linux command-line tools while demonstrating:

- Creation and configuration of the `forensic01` user.
- Switching to `forensic01`.
- Creation of `/home/forensic01/logs/`.
- Creation and analysis of `sys_events.log`.
- Use of `grep`, piping, redirection, `less`, `head`, `tail`, and `cat`.
- File permissions with `chmod`.
- File ownership with `chown`.
- User modification with `usermod`.
- Creation and deletion of temporary users.
- Evidence collection for the required submission.

## Requirements

### Part 1 — New User Setup

1. Create `forensic01` with:
   - a home directory
   - `/bin/bash` shell
   - membership in the `sudo` group
   - a password
2. Login/switch to `forensic01`.
3. Create `/home/forensic01/logs/`.
4. Create `sys_events.log` with at least 20 mock log lines using `cat` and `echo`.
5. Include `ERROR`, `WARNING`, `INFO`, `user01`, `root`, and timestamps in the mock logs.

### Part 2 — Log Filtering & Analysis

- Search for `ERROR`.
- Extract lines mentioning `root` or `user01`.
- Pipe grep results to `less`.
- Save the ERROR results to `error_report.txt`.
- Display the first 5 lines.
- Display the last 5 lines.
- Display the entire log with `cat`.

### Part 3 — Permissions and Ownership

- Create `confidential.txt` in `logs/`.
- Set it to read/write for the owner and no access for group/others.
- Change its owner to `root` using `sudo`.
- Attempt to read/edit it as `forensic01`.

### Part 4 — User Management

- Create `guest1` and `guest2`.
- Add `guest1` to `sudo`.
- Remove `guest2` including its home directory.

## Technologies / Tools

- Kali Linux or another Linux environment supporting the required commands
- Bash
- `useradd`
- `passwd`
- `su`
- `mkdir`
- `cat`
- `echo`
- `grep`
- `less`
- `head`
- `tail`
- `chmod`
- `chown`
- `usermod`
- `userdel`
- `ls`
- `id`

## Prerequisites

- A Linux/Kali Linux system.
- An account with permission to use `sudo`.
- Permission to create and remove local test users.
- A terminal.

## Important Permission Notes

Commands that create or modify system users normally require `sudo`. Commands performed after switching to `forensic01` should be run as `forensic01` unless the task explicitly requires `sudo`.

Do not use `sudo` when testing access to `confidential.txt`; the task is specifically testing what `forensic01` can access after ownership changes.

## Project Structure

```text
forensic-linux-log-analysis/
├── README.md
├── .gitignore
├── docs/
│   ├── README.md
│   └── task-overview.md
├── workflow/
│   ├── README.md
│   └── workflow.md
├── commands/
│   ├── README.md
│   └── commands.sh
├── scripts/
│   └── README.md
├── evidence/
│   ├── README.md
│   ├── screenshots/
│   │   └── .gitkeep
│   └── terminal-output/
│       └── .gitkeep
└── submission/
    ├── README.md
    ├── command-history.txt
    └── final-output.txt
```

## Workflow

Follow `workflow/workflow.md` from beginning to end. The workflow identifies whether a command should be run as the original administrator-capable account, `sudo`, or `forensic01`.

## Commands

The ordered command reference is in `commands/commands.sh`. It is intentionally a command reference rather than an unattended automation script because the activity includes password prompts, user switching, evidence capture, and a deliberate permission-denied test.

## Expected Results

At completion:

- `forensic01` exists and belongs to `sudo`.
- `/home/forensic01/logs/sys_events.log` exists with at least 20 mock log lines.
- `error_report.txt` contains the ERROR search results.
- The first and last five log lines can be displayed.
- `confidential.txt` has `600` permissions.
- Ownership of `confidential.txt` is changed to `root`.
- Reading/editing `confidential.txt` as `forensic01` demonstrates restricted access.
- `guest1` exists and is in `sudo`.
- `guest2` has been removed with its home directory.

## Evidence

Use `evidence/README.md` for the required screenshot checklist. Do not create or claim fake evidence. Place your actual screenshots under `evidence/screenshots/` and useful captured terminal output under `evidence/terminal-output/`.

## Submission

The activity requires:

- `commands_used.txt` containing the exact commands used.
- Screenshots of key terminal outputs, including grep results, permission checks, and other relevant evidence.
- A 2–3 line explanation each of `grep`, `chown`, and `usermod`.
- A short explanation of what was learned from attempting to access `confidential.txt` after its ownership changed.

Use `submission/README.md` as the final checklist and put your actual submission materials there if desired.

## Troubleshooting

### `Permission denied` when creating system users

Run the account-management command with `sudo` and make sure your current account is authorized to use `sudo`.

### `su - forensic01` fails

Verify the account exists:

```bash
id forensic01
```

If needed, set/reset its password:

```bash
sudo passwd forensic01
```

### `confidential.txt` is still readable

Check both ownership and permissions:

```bash
ls -l confidential.txt
```

The target should show `root` ownership and `-rw-------` permissions.

### `guest2` cannot be removed

Make sure you are not logged in as `guest2`. Use:

```bash
sudo userdel -r guest2
```
