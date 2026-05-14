# Round 2: 测试策略 (Testing Strategy)

**Priority:** P0
**Role:** 质量官
**Dependencies:** R1 (needs module map)
**Goal:** Establish testing framework, first test targets, and coverage baseline.

---

## What to Scan

```
- Glob: **/*.test.*, **/*.spec.* — any existing tests?
- Read: package.json scripts — any test command?
- Grep: core file imports — identify testable pure functions
- Bash: try running the test command if it exists
```

## Key Questions

1. **Zero tests?** — Priority is first test, not coverage.
2. **If tests exist** — Unit or integration? Fast? Test behavior or impl?
3. **Framework fit** — What matches language + build system?
4. **First targets** — 3-5 most critical and testable files?
5. **CI integration** — Can tests run without network/DB?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| Test framework setup | Install + configure |
| First test batch | 3-5 pure-logic files |
| Test naming convention | `{module}.test.ts` co-located |
| Coverage target | Initial threshold (e.g., 50% core) |
| Error boundary tests | Test error paths produce correct errors |

## Output Requirements

Gap analysis, framework recommendation, 3-5 test targets, error handling pattern, coverage target.
