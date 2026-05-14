# Project Readiness Council — Design Philosophy

The Project Readiness Council (PRC) is a structured evaluation and generation framework for establishing engineering baselines on brownfield projects. This document explains the five design principles that govern every decision in the framework.

## 1. Executor, Not Checker

Most readiness tools produce a report: a list of what is missing, what is wrong, what needs attention. The PRC does not stop at diagnosis.

Each round generates concrete, project-specific output files:

- A `CLAUDE.md` tailored to the project's language, toolchain, and conventions.
- CI configuration files (e.g., `.github/workflows/ci.yml`) with real workflows, not stubs.
- Tool configuration files (linters, formatters, test runners) pre-wired for the project's stack.
- A `docs/architecture.md` with the decisions captured during the council session.

The deliverable is a **ready-to-commit project standard** — not a to-do list. This is the fundamental distinction between PRC and a linter or audit tool.

## 2. Progressive by Default

Not every project needs every round. The 8 rounds are divided into three tiers based on archetype detection:

| Tier | Rounds | Applies To |
|------|--------|------------|
| **P0** | Architecture, Testing, Toolchain | Every project |
| **P1** | Git Hygiene, CI/CD, Security | Most projects |
| **P2** | Monitoring, Documentation | Services, public packages |

The framework auto-selects rounds based on:

- **Project archetype** (CLI tool, web service, library, monorepo, etc.)
- **Language and framework** detected during scanning
- **Existing artifacts** (is there already a CI file? A test runner config?)

A simple CLI script does not need the Monitoring round. A web service does not need the same Documentation depth as an open-source library. The framework never forces a round onto a project that does not benefit from it.

## 3. Multi-Perspective Is Not Multi-Person

The PRC defines six distinct roles, each with a unique lens on the project:

| Role | Perspective |
|------|-------------|
| Architect | Structural integrity, dependency health |
| Tester | Test coverage, testability debt |
| Ops | Deployability, observability |
| Security | Threat surface, credential hygiene |
| Reviewer | Code review conventions, team workflow |
| Product | Feature readiness, scope clarity |

These roles represent **perspective modes**, not people. A single developer running the PRC plays all six roles sequentially. The value comes from deliberately switching frames of reference — asking "what would a security engineer notice here?" even when you are the same person who wrote the code.

This makes the framework practical for solo developers and small teams while preserving the depth of a multi-stakeholder review.

## 4. Decision-Gated Execution

Every round follows a strict three-phase flow:

1. **Scan** — Discover what exists (config files, CI, tests, docs).
2. **Present** — Show findings and proposed changes to the user.
3. **Gate** — Wait for explicit approval before writing any file.

The gating mechanism produces a **decision record** (`READINESS_DECISIONS.md`) that lives in the project forever. This file contains:

- What was proposed during each round.
- Whether it was accepted, rejected, or deferred.
- The user's rationale for each decision.

This serves two purposes:

- **Traceability** — Future maintainers can see why CI was configured a certain way, or why a particular lint rule was chosen.
- **Accountability** — The framework never modifies a project without informed consent. No "AI wrote files I did not understand."

## 5. Dogfooding

The PRC framework must pass its own readiness evaluation. Every archetype definition, every round template, every role description must be internally consistent and self-applicable.

This means:

- Running the PRC on its own repository must produce sensible, non-contradictory output.
- Every round template must be concrete enough to generate real files for its own project.
- The framework's own `CLAUDE.md` should be generatable by the framework.
- Archetype configurations must detect their own repo accurately.

If the framework cannot pass its own audit, it is not ready for other projects.

---

## Relationship to AMPHOREUS Design Council

The PRC is one of two structured evaluation frameworks in the broader ecosystem. They serve complementary purposes:

| Dimension | AMPHOREUS Design Council | PRC (Project Readiness Council) |
|-----------|--------------------------|--------------------------------|
| **Scope** | Zero-constraint architecture debate | Brownfield project engineering baseline |
| **Input** | Problem statement, domain | Existing codebase, configs |
| **Output** | RFC, architecture decision records | CLAUDE.md, CI files, tool configs |
| **Constraints** | None — pure design space | Project language, toolchain, team size |
| **When to use** | Greenfield or major redesign | Bringing existing project up to standard |
| **Roles** | Domain expert, Solution Arch, Reviewer, etc. | Architect, Tester, Ops, Security, etc. |

**Shared pattern:** Both frameworks use structured multi-role deliberation to surface issues that a single-pass review would miss. The council format — sequential role presentations with cross-examination — is common to both.

**Key difference:** AMPHOREUS asks "what should we build?" The PRC asks "is what we built ready, and what do we need to add?" They are complementary: a project might go through AMPHOREUS at design time and PRC at ship time.

**Overlap:** Projects that use AMPHOREUS during design will find the PRC's Architecture round naturally references and validates the ADRs produced by AMPHOREUS, creating a closed loop from design to baseline.
