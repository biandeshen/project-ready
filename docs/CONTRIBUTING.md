# Contributing to Project Readiness Council

This document covers how to extend the framework with new rounds, roles, archetypes, and other components.

---

## Adding a New Round Template

Rounds are the core evaluation units of the PRC. Each round scans a specific dimension of project readiness and generates corresponding outputs.

### Steps

1. **Create the round file** at `src/rounds/{N}-{name}.md`, where `{N}` is the round number and `{name}` is a short hyphenated identifier (e.g., `4-ci-cd.md`).

2. **Follow the required structure:**

   ```
   # Round {N}: {Title}
   
   ## What to Scan
   <Files, directories, config keys this round inspects>
   
   ## Key Questions
   <Questions the council roles should answer during this round>
   
   ## Standard Proposals
   <What files this round typically generates and their default content>
   
   ## Output Requirements
   <Expected modifications or additions to the project>
   ```

   Every round template must include all four sections. Missing sections will cause validation failure.

3. **Register in the dependency graph.** Open `docs/playbook.md` and add the new round to Step 1.1 (Round Selection). If the new round depends on output from existing rounds, declare those dependencies explicitly.

4. **Update archetype recommendations** (if applicable). If the new round is relevant to specific project types, add it to the `recommendations.rounds` array in the appropriate archetype config(s) under `src/archetypes/`.

### Guidelines

- Keep standard proposals generic enough to apply across languages but specific enough to generate real files.
- Avoid overlap with existing rounds. If your round addresses CI/CD, it should complement rather than duplicate the existing CI/CD round.
- Each round should produce at least one file artifact (config, doc, or workflow).

---

## Adding a New Role

Roles define the perspective from which a round is evaluated. Adding a new role means adding a new lens that the council applies to every round.

### Steps

1. **Create the role file** at `src/roles/{N}-{name}.md`, where `{N}` is a unique role number.

2. **Define these required fields:**

   ```
   # Role: {Name}
   
   ## Perspective
   <One-paragraph description of what this role cares about>
   
   ## Priority
   <When this role speaks in the council sequence>
   
   ## What You Look For
   <Specific patterns, smells, and red flags this role identifies>
   
   ## Gap Categories
   <The types of gaps this role is responsible for flagging>
   
   ## Output Expectations
   <What artifacts or decisions this role produces>
   ```

3. **Special note on 清零者:** The 清零者 (Zero-Clear) role is a cross-round meta-role. It does not belong to any single round — instead, it reviews the output of all rounds to look for blind spots, contradictions, and missed interactions between concerns. New roles should not attempt to replicate this function.

### Guidelines

- Roles should have non-overlapping perspectives. If two roles would flag the same issues, one of them is redundant.
- Roles should produce actionable output, not just observations.
- Consider whether the role applies across all rounds or only specific ones.

---

## Adding or Updating an Archetype

Archetypes define how the framework adapts to different project types.

### Steps

1. **Edit or create** a JSON file at `src/archetypes/{name}.json`.

2. **Structure the config:**

   ```json
   {
     "name": "{archetype-name}",
     "detection": {
       "files": ["<files whose presence suggests this archetype>"],
       "patterns": ["<regex patterns in existing configs>"],
       "priority": <number, higher = preferred when multiple match>
     },
     "recommendations": {
       "roles": ["<role names that are most relevant>"],
       "rounds": ["<round numbers or names to activate>"],
       "outputs": ["<additional outputs beyond defaults>"]
     },
     "languageDepth": {
       "<language>": {
         "lintConfig": "<recommended linter config>",
         "testFramework": "<recommended test framework>",
         "extraChecks": ["<language-specific checks>"]
       }
     }
   }
   ```

3. **The `detection` section** determines when this archetype activates. At least one file or pattern must match; otherwise the archetype is skipped.

4. **The `recommendations` section** links to roles and rounds. These are suggestions, not overrides — the playbook may still exclude a round for other reasons.

5. **The `languageDepth` section** adds language-specific checks on top of the generic round templates. This is where framework- or language-specific configuration goes (e.g., pytest for Python, Jest for JavaScript).

### Guidelines

- Archetypes should be detectably different. If two archetypes would activate on the same project, differentiate them with file-based detection rules and priority levels.
- Keep languageDepth entries focused on tooling and conventions, not coding style.
- Test detection against real projects before submitting.

---

## Pull Request Process

1. **Describe what changed and why.** Every PR must explain the motivation. "Adding X because Y" is the minimum bar.

2. **Include a test run for new rounds.** If adding a round template, run it against a demo project and include the output (or a summary) in the PR description.

3. **Document workflow impact for playbook changes.** If modifying `docs/playbook.md`, explain how the execution flow changes. Include a before/after comparison if the change is nontrivial.

4. **Keep changes focused.** A PR should address one addition or change. Do not mix a new round with refactoring an existing one in the same PR.

5. **Pass the dogfood check.** The framework must remain self-applicable. If your change breaks the ability to run the PRC on its own repo, it will not be merged.
