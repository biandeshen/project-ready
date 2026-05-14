# Project Readiness Playbook — Execution Workflow

> Claude Code: read this file and follow it step by step.
> Do NOT skip steps. Do NOT combine independent steps.
>
> Target: any software project that lacks engineering baselines.
> Estimated time: 15-90 minutes (lightning: ~15min, full: 45-90min).
> Role: you act as the **主持人 (Moderator)** orchestrating the flow.

---

## Step 0: Project Diagnosis

### 0.1 Scan the project

Run ALL in parallel:

```
- Bash: ls <root>
- Bash: git log --oneline -10
- Glob: **/package.json, **/Cargo.toml, **/pom.xml, **/Gemfile, **/requirements.txt, **/go.mod, **/setup.py
- Glob: **/*.test.*, **/*.spec.*, **/jest.config*, **/vitest.config*, **/pytest.ini
- Glob: */.eslint*, */.prettier*, */biome.json, *.editorconfig
- Glob: **/.github/workflows/*.yml
- Glob: *CLAUDE.md, *CONTRIBUTING.md
- Read: .gitignore, tsconfig.json or equivalent
- Bash: git status --short
- Glob: **/*.{ts,tsx,js,jsx,py,go,rs}
```

### 0.2 Detect project archetype

Read all files from `src/archetypes/` and match against scan results.

Apply archetype's `languageDepth` checks as extensions to the round templates.

### 0.3 Lightning mode check

**If ≤5 source files and ≤1 dependency manifest:**

```
This project appears small (<5 source files). Recommend lightning mode:
  R1 Quick Scan + R2 Mini (single test file)

Proceed with lightning mode? (Yes / Full mode)
```

If yes → run only R1 (compressed) + R2 (compressed: one test file). Skip all else.

### 0.4 Build profile + propose plan

Fill `src/templates/project-profile.md` with findings.

Present plan and wait for confirmation.

### 0.5 Handle modifications

Accept: add/remove rounds, priority changes, deferral.
**Deferral rule:** Record deferred rounds in final summary with reason.

---

## Step 1-X: Execute Selected Rounds

### 1.1 Rules

- Execute per dependency graph. Parallel-able pairs are explicitly noted.
- For each round: load template + role, spawn subagent, write output, present.

Dependency graph:

```
R1 Architecture
  ├── R2 Testing (needs module map)
  ├── R3 Toolchain (independent)
  │     └── R4 Git Workflow (needs hook decisions)
  ├── R6 Security (independent)
  └── R7 Documentation (needs architecture)
         └── R8 Monitoring (needs module structure)
R5 CI/CD after R2+R3+R4
```

### 1.2 Per-round interaction

After each round output, user can: Approve / Modify / Reject / **Defer**

"Defer" marks OPEN questions as unresolved and moves on.

### 1.3 Cross-round: 清零者介入

After **all** selected rounds have output, spawn the 清零者:

```
Agent: "清零者 cross-round review"
Prompt: |
  You are the 清零者 (Reset Perspective) — cross-round meta-reviewer.

  Read ALL round outputs.

  Use your three tools:
  1. Premise questioning — What did all rounds assume without proving?
  2. Blind spot detection — What did no round mention?
  3. Reverse reasoning — What if the core finding is wrong?

  Read role: src/roles/06-reset-perspective.md
  Write to: outputs/round-99-reset-perspective.md
```

Present the report to user.

---

## Final Step: Decision & Implementation

### Compile decision document

Read ALL round outputs (including 清零者). Fill `src/templates/decision-document.md`.

Save to: **`READINESS_DECISIONS.md`** in the target project root.

### Present final summary

### Execute decisions

After user approves:

1. **Generate CLAUDE.md** — test conventions, code style, commit conventions, architecture notes
2. **Create config files** — only approved ones
3. **Generate status badge** if user agrees:

```
[![Readiness: Architecture ✅ Testing ✅ Toolchain ✅ CI/CD ❌ Security ⏳ Docs ✅ Monitoring ⬜]()]
```

Legend: ✅ implemented, ❌ rejected, ⏳ deferred, ⬜ not selected

4. **Commit** — `chore: project readiness baseline`

### Result persistence

`READINESS_DECISIONS.md` stays in the target project permanently. Serves as:
- Traceability for future developers
- Recovery point for interrupted sessions
- Baseline for next audit

---

## Execution Rules

1. **User is always in control.** Every step requires confirmation.
2. **Never write outside `.claude/readiness/outputs/` without approval.**
3. **Respect existing configs** — don't blindly overwrite.
4. **Subagent isolation** — include all context in the prompt.
5. **Defer is not failure** — better to defer than force a bad decision.
6. **清零者 reads ALL rounds.** He's cross-cutting, not per-round.
7. **Keep round outputs factual.** Evidence over opinions.
