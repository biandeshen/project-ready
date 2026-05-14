# Round 6: 安全基线 (Security Baseline)

**Priority:** P1 (P0 for API/user-facing projects)
**Role:** 安全官
**Dependencies:** None
**Goal:** Identify and remediate immediate security risks.

---

## What to Scan

```
- Grep: "api_key" "apikey" "password" "secret" "token" "sk-" — hardcoded secrets
- Grep: "http://" — missing TLS
- Bash: npm audit or equivalent
- Grep: "eval(" "exec(" "shell" "spawn" — injection points
```

## Key Questions

1. **Secrets in source?** — Committed API keys, tokens?
2. **Dependency CVEs** — Known vulnerabilities?
3. **Input validation** — External inputs validated?
4. **Environment separation** — Dev/staging/prod configs?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| Secrets audit | Scan + remove + .gitignore |
| Deps update | Fix CVEs + add audit to CI |
| Input validation | Runtime validation at boundaries |
| CORS policy | Explicit origins, not wildcard |
| Rate limiting | If API: rate limit middleware |

## Output Requirements

Gap analysis with severity, P0 remediation, P1 improvements, P2 best practices.
