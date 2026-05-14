# Round 1: 架构基线 (Architecture Baseline)

**Priority:** P0
**Role:** 架构师
**Dependencies:** None
**Goal:** Establish type safety, module boundaries, error handling, and dependency conventions.

---

## What to Scan

```
- Read: tsconfig.json or equivalent type config
- Read: 3-5 representative source files across different modules
- Read: package.json dependencies section
- Grep: "any" in .ts files (TypeScript escape hatch count)
- Grep: "catch" / ".catch" / "try {" — how errors are handled
- Grep: "TODO" / "FIXME" / "HACK" — technical debt markers
- Glob: **/*.ts, **/*.tsx, **/*.py, **/*.go, **/*.rs — count files per type
```

## Key Questions

1. **Module structure** — Is it clear where each concern lives?
2. **Type strictness** — Could this project enable strict mode? What would break?
3. **Error model** — How does the code communicate failure? Null/throw/Result?
4. **Dependency health** — Unused deps? Wrong-level deps?
5. **Build reproducibility** — Does clean install + build work consistently?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| Type strictness target | Enable strict mode + fix violations |
| Error handling convention | Choose a pattern and document it |
| Module naming convention | PascalCase vs kebab-case convention |
| Dependency audit | Remove unused, fix wrong-level deps |
| Entry point documentation | Doc comment per module entry |

## Output Requirements

Produce gap analysis, module map, proposals (0-3 from above), priority assessment.
