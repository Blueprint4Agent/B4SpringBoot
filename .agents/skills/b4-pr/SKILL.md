---
name: b4-pr
description: Publish or update B4SpringBoot pull requests using the repository template, and merge only when requested.
---

# B4 pull request

Adapted from B4FastAPI's repository skill. Resolve the Git root and remote repository.
Read [AGENTS.md](../../../AGENTS.md) and the current
[PR template](../../../.github/PULL_REQUEST_TEMPLATE.md).

1. Inspect the branch, status, target branch, authored commits, and any PR for this
   head. Update an existing task PR instead of creating a duplicate. For unfinished
   commits, use the adjacent [b4-commit](../b4-commit/SKILL.md) procedure.
2. Write an English `[type] Concise title` and a body using the template's sections.
   Describe final behavior, scope, observed verification, and relevant risks.
   Remove unused placeholders. Link real related issues and use `Closes` only for
   issues this PR resolves. Check available labels before applying them.
3. Keep publication within the requested scope. Push the intended committed branch
   using normal hooks. Use connected GitHub tools when available, or authenticated
   `gh` with a UTF-8 `--body-file`. Use a ready PR unless a draft is requested or
   an actual blocker remains.
4. Read back the title, body, labels, base/head, head SHA, draft state, and issue
   links. After an uncertain mutation result, inspect remote state before retrying.
   Run repository-specific PR checks only when implemented here. Report the URL
   and actual open, pending, or merged state.

## Requested merge

Merge only when the user authorizes it. Recheck the current head, reviews,
conversations, and available checks before merging. Preserve branch protections.
Use a merge commit by default; squash or rebase needs a user request. Verify the
resulting commit or pending auto-merge state instead of assuming completion.
