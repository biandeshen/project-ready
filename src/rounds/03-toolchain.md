# Round 3: 工具链 (Toolchain)

**Priority:** P0
**Role:** DevOps 工程师
**Dependencies:** None
**Goal:** Establish linter, formatter, pre-commit hooks, and dev environment consistency.

---

## What to Scan

```
- Glob: */.eslint*, */biome.json, *.prettierrc*, *.editorconfig
- Glob: */.husky/*, */.lefthook*
- Glob: */.vscode/settings.json, */.devcontainer/*
- Read: .gitignore adequacy
```

## Key Questions

1. **Linter/formatter** — Installed? Configured? Cover all file types?
2. **Pre-commit hooks** — Any guard against committing broken code?
3. **Editor consistency** — .editorconfig or VS Code workspace settings?
4. **Build/start scripts** — Documented? Platform-independent?
5. **Gitignore** — Cover build outputs, IDE, OS, secrets?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| Linter config | ESLint/Biome with project-relevant rules |
| Formatter config | Prettier with consistent settings |
| Pre-commit hooks | Husky/lefthook: lint-staged |
| Editor settings | .editorconfig + recommended extensions |
| Gitignore update | Cover all standard exclusions |

## Output Requirements

Gap analysis, tool recommendations, CI pipeline design, hook config, dev env proposal.
