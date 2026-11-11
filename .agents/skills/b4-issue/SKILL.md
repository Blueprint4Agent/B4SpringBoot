---
name: b4-issue
description: Create or update B4SpringBoot GitHub issues from repository templates with duplicate checks and verifiable acceptance criteria.
---

# B4 issue

Adapted from B4FastAPI's repository skill. Resolve the intended repository and read
[AGENTS.md](../../../AGENTS.md). Use the current files in
[.github/ISSUE_TEMPLATE](../../../.github/ISSUE_TEMPLATE) as the source for issue
type, title prefix, sections, and suggested labels.

1. Search open and relevant closed issues for the same problem. Inspect matches
   before creating or updating an issue; preserve unrelated issues.
2. Choose the closest existing template and use its body headings without the YAML
   frontmatter. Write issue titles and bodies in English. Check that suggested
   labels exist remotely before applying them.
3. Describe observed or requested behavior, affected scope, and verifiable acceptance
   criteria. For bugs, separate reproduction, expected behavior, and actual behavior.
   Mark unknown causes or environment details as unconfirmed. Link available evidence.
4. For creation or update requests, publish within that scope using connected GitHub
   tools or authenticated `gh` with a UTF-8 `--body-file`. A draft or review-only
   request returns prepared text without publishing. An issue task does not itself
   authorize implementation, repository commits, or PRs.
5. Read back title, body, labels, and URL. Inspect remote state before retrying an
   uncertain API result, then report the actual outcome.

An issue-only action with no local file changes does not require a commit or worklog.
