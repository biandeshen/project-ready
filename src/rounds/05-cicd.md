# Round 5: CI/CD 基线 (CI/CD Baseline)

**Priority:** P1
**Role:** DevOps 工程师
**Dependencies:** R2 (test), R3 (lint), R4 (branch strategy)
**Goal:** Set up automated CI pipeline that checks every PR.

---

## What to Scan

```
- Glob: **/.github/workflows/*.yml
- Read: existing workflow files
- Read: package.json scripts — test/lint/build commands
```

## Key Questions

1. **CI exists?** — Effective? Catches real issues?
2. **CI missing?** — What's blocking?
3. **Platform** — GitHub Actions? GitLab CI?
4. **What to check** — Minimal: lint → typecheck → test → build
5. **Speed** — How long? Can it be parallelized?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| GitHub Actions CI | `.github/workflows/ci.yml` |
| PR gate | Required checks before merge |
| Cache strategy | Dep caching for speed |
| Matrix builds | Multi-platform if needed |
| Status badge | README badge |

## Output Requirements

Gap analysis, CI workflow YAML content, required checks, badge config.
