# Round 8: 监控与可观测性 (Monitoring & Observability)

**Priority:** P2 (P1 for services/daemons)
**Role:** DevOps 工程师
**Dependencies:** R1 (module structure for instrumentation points)
**Goal:** Establish logging, error tracking, and performance baselines.

---

## What to Scan

```
- Grep: "console.log" "console.error" "logger" — logging method
- Grep: "try" "catch" — errors logged when caught?
- Glob: **/sentry*, **/datadog* — monitoring SDKs?
- Read: error handler middleware if exists
```

## Key Questions

1. **Logging strategy** — Consistent logger or console.log?
2. **Error tracking** — Errors collected or invisible?
3. **Performance baseline** — Any way to detect slowness?
4. **Health checks** — `/health` endpoint?
5. **Startup validation** — Dependencies checked on boot?

## Standard Proposals

| Proposal | Description |
|:---------|:------------|
| Logger setup | Structured logging with levels |
| Error reporting | Sentry or equivalent |
| Health check | `/healthz` checking critical deps |
| Startup probe | Config + connectivity validation |
| Logging standard | Format: timestamp level module message |

## Output Requirements

Observability gap analysis, logging strategy, error tracking recommendation, health check design.
