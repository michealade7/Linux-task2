# Complete Practical Workflow

## Phase 1 — Create `forensic01`

### Step 1: Create the user

**Run as:** an account authorized to use `sudo`.

```bash
sudo useradd -m -s /bin/bash -G sudo forensic01
```

**Expected result:** the `forensic01` account is created with a home directory, Bash shell, and `sudo` group membership.

**Verify:**

```bash
id forensic01
```

**Evidence:** capture the `id forensic01` output.

### Step 2: Set the password

**Run as:** `sudo`.

```bash
sudo passwd forensic01
```

Enter and confirm a password when prompted.

---

## Phase 2 — Switch to `forensic01`

### Step 3: Switch user

```bash
su - forensic01
```

**Verify:**

```bash
whoami
pwd
```

Expected:

```text
forensic01
/home/forensic01
```

**Evidence:** capture `whoami` and `pwd`.

---

## Phase 3 — Create the Log Workspace

### Step 4: Create the required directory

**Run as:** `forensic01`.

```bash
mkdir -p /home/forensic01/logs
cd /home/forensic01/logs
```

**Verify:**

```bash
pwd
ls -la
```

---

## Phase 4 — Create the Mock Log

### Step 5: Create `sys_events.log`

The task requires at least 20 mock lines and requires timestamps plus the terms `ERROR`, `WARNING`, `INFO`, `user01`, and `root`.

Use `cat` for the multi-line file and `echo` for an additional line. The exact command is provided in `commands/commands.sh`.

**Verify:**

```bash
wc -l sys_events.log
cat sys_events.log
```

The line count must be at least 20.

**Evidence:** capture the log contents and/or line-count verification.

---

## Phase 5 — Filter and Analyze the Log

### Step 6: Find ERROR lines

```bash
grep "ERROR" sys_events.log
```

**Evidence:** capture the output.

### Step 7: Find `root` or `user01`

```bash
grep -E "root|user01" sys_events.log
```

**Evidence:** capture the output.

### Step 8: Pipe grep output to `less`

```bash
grep "ERROR" sys_events.log | less
```

Press `q` to exit `less`.

### Step 9: Save ERROR results

```bash
grep "ERROR" sys_events.log > error_report.txt
```

**Verify:**

```bash
cat error_report.txt
```

---

## Phase 6 — Use `head`, `tail`, and `cat`

### Step 10: First five lines

```bash
head -n 5 sys_events.log
```

### Step 11: Last five lines

```bash
tail -n 5 sys_events.log
```

### Step 12: Entire file

```bash
cat sys_events.log
```

Capture evidence for the requested terminal outputs.

---

## Phase 7 — Permissions and Ownership

### Step 13: Create `confidential.txt`

**Run as:** `forensic01`.

```bash
echo "This file contains confidential forensic information." > confidential.txt
```

### Step 14: Set owner-only read/write permissions

```bash
chmod 600 confidential.txt
```

**Verify:**

```bash
ls -l confidential.txt
```

Expected permission pattern:

```text
-rw-------
```

At this stage the owner should be `forensic01`.

**Evidence:** capture the permission check.

### Step 15: Change ownership to root

```bash
sudo chown root:root confidential.txt
```

**Verify:**

```bash
ls -l confidential.txt
```

Expected: owner and group are `root`.

**Evidence:** capture the ownership check.

### Step 16: Test access as `forensic01`

Do not use `sudo` for this test.

```bash
cat confidential.txt
```

Then, if required by the activity:

```bash
nano confidential.txt
```

The file's `600` permissions mean only its owner has read/write access. After ownership is changed to `root`, `forensic01` should no longer have normal read/write access.

Exit `nano` with `Ctrl+X`.

**Evidence:** capture the access result.

---

## Phase 8 — Temporary User Management

### Step 17: Create `guest1`

**Run as:** an account authorized to use `sudo`.

```bash
sudo useradd -m guest1
```

### Step 18: Create `guest2`

```bash
sudo useradd -m guest2
```

### Step 19: Set passwords if required by the system

```bash
sudo passwd guest1
sudo passwd guest2
```

### Step 20: Add `guest1` to sudo

```bash
sudo usermod -aG sudo guest1
```

**Verify:**

```bash
id guest1
```

Look for `sudo` in the group list.

### Step 21: Remove `guest2` and its home directory

```bash
sudo userdel -r guest2
```

**Verify:**

```bash
id guest2
```

The account should no longer exist.

---

## Phase 9 — Evidence Collection

Before finishing, check:

- `forensic01` creation and group membership.
- Successful switch to `forensic01`.
- Required logs directory.
- `sys_events.log`.
- ERROR grep output.
- `root|user01` grep output.
- `head` and `tail` output.
- `confidential.txt` permissions.
- `confidential.txt` root ownership.
- Permission/access test.
- `guest1` sudo membership.
- `guest2` removal.

Use `evidence/README.md` for filenames and evidence descriptions.

---

## Phase 10 — Final Submission

Prepare:

1. `commands_used.txt` with the exact commands actually used.
2. Required screenshots.
3. 2–3 line explanations of `grep`, `chown`, and `usermod`.
4. A short explanation of what was learned from the `confidential.txt` access test.

Do not submit generated placeholder evidence as if it were real evidence.
