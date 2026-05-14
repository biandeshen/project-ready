# Project Readiness Council — Roadmap

---

## v0.1 (Current) — Core Framework

The initial release establishes the fundamental execution model and template library.

### Implemented

- **playbook.md execution flow** — The council sequence, round orchestration, and file generation pipeline.
- **6 council roles**:
  - Architect
  - Tester
  - Ops
  - Security
  - Reviewer
  - Product
- **8 round templates** covering architecture, testing, toolchain, git hygiene, CI/CD, security, monitoring, and documentation.
- **3 output templates** for CLAUDE.md, CI workflows, and decision records.
- **7 archetype configurations** for common project types (CLI, web service, library, monorepo, mobile app, data pipeline, WordPress plugin).
- **Lightning mode** — A condensed execution path for small projects that skips verbose scanning and proceeds directly to high-priority proposals.
- **清零者 (Zero-Clear) cross-round meta-review** — A pass that runs after all rounds to catch blind spots, contradictions, and interaction effects between round outputs.
- **Deferral mechanism** — Rounds and individual proposals can be deferred with a rationale, recorded in the decision document for future re-audit.
- **Result persistence** — All round outcomes, decisions, and deferrals are written to `READINESS_DECISIONS.md` in the target project.

### Limitations (known)

- No automated test suite for the framework itself.
- No CI pipeline for the framework repository.
- Limited language depth — full support for JavaScript/TypeScript and Python; partial for others.
- Manual installation only (clone + symlink).

---

## v0.2 (Planned) — Production Hardening

Focus: making the framework reliable, testable, and self-sufficient.

### Self-Dogfood

Run the framework on its own repository as a CI gate. Any change that causes the framework to fail its own readiness check is automatically rejected. This ensures the dogfooding principle is enforced mechanically rather than culturally.

### Test Infrastructure

- **`validate-structure.sh`** — A structural integrity checker that verifies:
  - All round templates exist and contain the required four sections.
  - All role files exist and contain the required six fields.
  - All archetype JSON files are valid and reference only existing roles/rounds.
  - No orphan files exist in `src/rounds/`, `src/roles/`, or `src/archetypes/`.
- Round-trip testing: run the PRC on a synthetic project and verify the generated files match expected output.

### CI for the Framework

- GitHub Actions workflow that runs on push/PR:
  - Structural validation (`validate-structure.sh`).
  - Dogfood self-audit (run PRC on its own repo).
  - Integration tests against fixture projects.

### Installer Polish

- Cross-platform installer script (macOS, Linux, Windows via PowerShell).
- Installer confirms correct file paths and offers to add the framework to PATH.
- Uninstaller that removes symlinks and cleans up.

### Expanded Language Depth

- **Go archetype** — `go vet`, `golangci-lint`, Go test conventions, module hygiene.
- **Rust archetype** — `cargo check`, `clippy`, Rust edition conventions, workspace structure.
- **Kotlin archetype** — detekt, ktlint, Kotest/JUnit setup, Gradle conventions.

---

## v0.3 (Future) — Ecosystem

Focus: distribution, community contributions, and tooling integration.

### `npx create-readiness` (npm Package)

- One-command bootstrapping: `npx create-readiness` runs the PRC interactively.
- Optional `--lightning` flag for small projects.
- No global install required — runs via npx with all templates bundled.

### VS Code Extension

- Command palette integration: "Project Readiness Council: Run" and "Project Readiness Council: Re-audit".
- Inline annotations in `READINESS_DECISIONS.md` showing which rounds are stale.
- Tree view showing current readiness status by round.
- Quick-fix actions that open the relevant round template for editing.

### Community Archetype Registry

- A Git-based registry where contributors submit archetype JSON files.
- The framework can fetch and install archetypes from the registry by name.
- Versioned archetype releases with changelogs and migration notes.
- Curation process: archetypes in the registry pass a validation suite before acceptance.

### Incremental Re-Audit

- Compare current project state against the previous `READINESS_DECISIONS.md`.
- Skip rounds whose outputs are unchanged.
- Detect regressions: a decision that was previously "accepted" but whose preconditions are now violated.
- Produce a delta report showing only what changed since the last audit.

---

## v1.0 (Goal) — Stable Release

Focus: maturity, trust, and extensibility.

### Battle-Tested on 20+ Projects

The framework must have been run against at least 20 diverse real-world projects (across languages, team sizes, and domains) without:
- Producing contradictory output.
- Generating invalid configuration files.
- Missing critical readiness gaps that a human reviewer later identified.

### Community-Vetted Archetypes

At least 10 archetypes in the registry that have been:
- Reviewed by at least 2 community members.
- Tested against a reference project.
- Verified by the framework's structural validation suite.

### Plugin System for Custom Round Templates

- Third-party rounds can be loaded from external files or packages without modifying the core framework.
- Plugin API defines hooks for: scan, analyze, propose, generate.
- Plugin sandboxing to prevent unsafe operations.
- Version negotiation between the framework and plugins.

---

## Milestone Timeline (Indicative)

| Milestone | Target | Dependencies |
|-----------|--------|--------------|
| v0.1 release | Current | — |
| Self-dogfood CI gate | v0.2 | v0.1 stable |
| validate-structure.sh | v0.2 | v0.1 stable |
| Go / Rust / Kotlin archetypes | v0.2 | v0.1 archetype system |
| Cross-platform installer | v0.2 | v0.1 stable |
| npm package | v0.3 | v0.2 installer |
| VS Code extension | v0.3 | v0.2 structural validation |
| Community registry | v0.3 | v0.2 archetype system |
| Incremental re-audit | v0.3 | v0.2 decision persistence |
| 20+ project validation | v1.0 | v0.3 ecosystem |
| Plugin system | v1.0 | v0.2 round template format |
| v1.0 release | v1.0 | All above |

---

## Out of Scope (Explicitly)

The following are not planned for any version:

- **Real-time project monitoring.** The PRC is a point-in-time evaluation, not a daemon. Continuous checks belong in CI/CD.
- **Code generation beyond configs.** The PRC generates project standards (CLAUDE.md, CI configs, linter configs), not application code.
- **Architecture design.** The PRC evaluates existing architecture; it does not design new systems. That is the domain of AMPHOREUS Design Council.
