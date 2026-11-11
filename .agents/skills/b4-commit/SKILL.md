---
name: b4-commit
description: Prepare and create B4SpringBoot commits with scoped verification, English commit messages, and a reviewed staged diff.
---

# B4 commit

Adapted from B4FastAPI's repository skill. Resolve this repository's Git root;
commands below run from that root. Read [AGENTS.md](../../../AGENTS.md), inspect
status, branch, and diff, and preserve unrelated edits. Empty guides do not define
additional policy.

1. Confirm the requested commit scope. Use an existing task branch when appropriate.
   If a worklog is requested or required by populated repository guidance, use
   [.github/WORKLOG_TEMPLATE.md](../../../.github/WORKLOG_TEMPLATE.md). Record the
   actual planning and verification history; do not backdate a plan.
2. Select checks from the current root Makefile. For backend or build changes,
   `make verify` checks formatting, tests, and packaging. For Markdown-only changes,
   inspect changed links and run `git diff --check`. Record checks and omissions.
   Add governance or hook checks only when their tooling actually exists here.
3. Write an English Conventional Commit title and nonempty `Changes:`,
   `Affected Files:`, and `Verification:` body sections. If a worklog is used,
   keep its Commit Title consistent with the final message.
4. Stage only the intended files. Inspect `git diff --cached` and run
   `git diff --cached --check`. Preserve existing hooks and resolve failures.
   Use a temporary UTF-8 message file with `git commit -F <file>`.
5. Report the commit and observed checks. A commit-only task ends here; push,
   PR creation, and merging must remain within the user's requested scope.
