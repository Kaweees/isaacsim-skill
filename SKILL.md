---
# `name` MUST match the parent directory name (here: isaacsim-skill).
name: isaacsim-skill
description: >
  Template Agent Skill for Isaac Sim workflows. Replace this description with
  what the skill does and when agents should use it. Include concrete trigger
  phrases (e.g. Isaac Sim, USD stages, sensors, robotics simulation) so the
  skill activates on the right tasks.
license: MIT
# compatibility: Optional. Environment requirements (max 500 chars).
#   Example: Requires Isaac Sim 4.5+, Python 3.10+, and a GPU-capable host
metadata:
  author: your-org-or-name
  version: "0.1.0"
# allowed-tools: Optional experimental field. Space-separated pre-approved tools.
#   Example: Bash(git:*) Bash(jq:*) Read
---

# Isaac Sim Skill (template)

Brief overview: what capability this skill adds and the outcome it should produce.
Keep this body focused — agents load the full file when the skill activates.
Recommended: under 500 lines / ~5,000 tokens. Move detail into `references/`.

Replace every placeholder section below with domain-specific instructions.

## When to use

- Situation or user request that should activate this skill (e.g. Isaac Sim setup, scene authoring, sim APIs)
- Related keywords or task types
- When **not** to use this skill (avoids false activations)

## Prerequisites

- Tools, runtimes, or access the agent needs (e.g. Node 18+, `uv`, API credentials)
- How to verify they are available before starting

## Workflow

Follow these steps in order. Prefer procedures over one-off answers.

### 1. Gather context

- What inputs are required from the user or repo?
- What should you inspect first?

### 2. Do the work

- Default approach and commands (pin versions when using package runners)
- Concrete examples the agent can adapt

```bash
# Example command — replace placeholders
# scripts/example.sh --input "$INPUT" --format json
```

### 3. Validate

- How to check the result is correct
- What to fix and re-run if validation fails

```bash
# Example validation
# python scripts/validate.py output/
```

### 4. Report

- What to tell the user when done (paths, summary, next steps)

## Available scripts

List bundled scripts so the agent knows they exist. Paths are relative to this skill root.

| Script | Purpose |
| --- | --- |
| `scripts/example.sh` | Example shell helper with flags and structured output |
| `scripts/example.py` | Example Python script with CLI args (no interactive prompts) |

Run with:

```bash
bash scripts/example.sh --help
python3 scripts/example.py --help
```

## Reference files

Load only when needed (progressive disclosure):

- [references/REFERENCE.md](references/REFERENCE.md) — detailed API notes, tables, edge cases
- Load when: you need field-level detail or uncommon error recovery

## Assets

Static templates and resources in `assets/`:

- Copy or adapt templates rather than inventing structure from scratch
- Load only when producing that output type

## Gotchas

Environment-specific facts that override reasonable defaults:

- Fact the agent would get wrong without being told
- Naming mismatches, soft-delete rules, brittle flags, etc.

## Output format

When a specific shape is required, give a template:

```markdown
# [Title]

## Summary
[One paragraph]

## Changes
- Item with path or evidence

## Next steps
1. Concrete follow-up
```

## Examples

### Example A: typical request

**User:** "…"

**Approach:**

1. …
2. …

**Result:** …

### Example B: edge case

**User:** "…"

**Approach:** …

## Checklist

- [ ] Inputs confirmed
- [ ] Main steps completed
- [ ] Validation passed
- [ ] User-facing summary written
