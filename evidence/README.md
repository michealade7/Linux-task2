# Evidence Collection

Do not create fake screenshots. Capture your own terminal output while performing the activity.

## Recommended screenshot checklist

| Filename | Capture | What it proves |
|---|---|---|
| `01-user-created.png` | `id forensic01` | `forensic01` exists and has `sudo` membership |
| `02-user-switch.png` | `whoami` and `pwd` | Work has switched to `forensic01` |
| `03-log-created.png` | `wc -l sys_events.log` and/or `cat sys_events.log` | Log exists and contains at least 20 lines |
| `04-error-grep.png` | `grep "ERROR" sys_events.log` | ERROR filtering |
| `05-root-user01-grep.png` | `grep -E "root|user01" sys_events.log` | Required account-name filtering |
| `06-head-tail.png` | `head -n 5` and `tail -n 5` | First/last five line checks |
| `07-permissions-before.png` | `ls -l confidential.txt` before ownership change | `600` permissions and original ownership |
| `08-permissions-after-chown.png` | `ls -l confidential.txt` after `chown` | Root ownership |
| `09-access-test.png` | `cat confidential.txt` and/or edit attempt as `forensic01` | Restricted access after ownership change |
| `10-guest1-sudo.png` | `id guest1` | `guest1` was added to sudo |
| `11-guest2-removed.png` | `id guest2` | `guest2` was removed |

## Terminal-output folder

If you save copied terminal output as text, place it under:

```text
evidence/terminal-output/
```

Use descriptive filenames such as:

```text
error-grep.txt
permission-check.txt
user-management.txt
```

## Screenshot tips

- Make sure the command and its output are visible.
- Avoid cropping away the relevant command.
- Do not include passwords.
- Use clear, meaningful filenames.
