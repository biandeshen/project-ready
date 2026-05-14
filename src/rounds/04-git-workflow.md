# Round 4: Git 工作流 (Git Workflow)

**Priority:** P1
**Role:** DevOps 工程师
**Dependencies:** R3 (needs hook decisions)
**Goal:** Establish branch strategy, commit conventions, and PR/issue templates.

---

## What to Scan

```
- Bash: git log --oneline -30 — examine commit style
- Bash: git branch -a — existing branches
- Glob: .github/ISSUE_TEMPLATE/*, .github/PULL_REQUEST_TEMPLATE/*
```

## Key Questions

1. **Commit style** — Consistent? Descriptive?
2. **Branch strategy** — main-only? feature branches?
3. **PR/Issue templates** — Exist? Ask the right info?
4. **Merge strategy** — Squash? Merge commit? Rebase?
5. **Release tagging** — Semver? Changelog?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| Commit convention | Conventional Commits (feat/fix/chore/docs/refactor/perf/test) |
| Branch naming | `{type}/{description}` |
| PR template | Description + test plan + screenshots + checklist |
| Issue templates | Bug report + feature request |
| Release process | Version + changelog + tag |

## Output Requirements

Gap analysis, commit convention, branch strategy, PR/issue templates.
