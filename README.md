# Agent Skill Template

A ready-to-edit template for an [Agent Skill](https://agentskills.io/) — the open format for giving AI agents specialized knowledge and workflows.

Compatible agents load skills on demand: they read `name` and `description` at startup, then load the full `SKILL.md` only when a task matches.

## Layout

```
.
├── SKILL.md           # Required: YAML frontmatter + instructions
├── scripts/           # Optional: executable helpers
│   ├── example.sh
│   └── example.py
├── references/        # Optional: docs loaded on demand
│   └── REFERENCE.md
├── assets/            # Optional: templates, images, sample data
│   └── README.md
├── LICENSE
└── README.md
```

Only `SKILL.md` is required. Keep optional folders when they help; delete them when they do not.

## Quick start

1. **Rename the skill**
   - Folder name and frontmatter `name` must match (lowercase, digits, hyphens; no leading/trailing or consecutive hyphens; max 64 characters).
   - If this repo is the skill itself, the directory name should match `name` in `SKILL.md` when you publish or install it.

2. **Edit frontmatter in `SKILL.md`**

   | Field | Required | Notes |
   | --- | --- | --- |
   | `name` | Yes | Identifier; must match the skill directory name |
   | `description` | Yes | What it does **and** when to use it (max 1024 chars). This drives activation. |
   | `license` | No | License name or path to a license file |
   | `compatibility` | No | Runtime needs (packages, network, product) |
   | `metadata` | No | Free-form string map (`author`, `version`, …) |
   | `allowed-tools` | No | Experimental; space-separated pre-approved tools |

3. **Write instructions** in the Markdown body: steps, defaults, gotchas, validation, and examples. Prefer procedures over one-off answers. Keep the body under ~500 lines; put deep detail in `references/`.

4. **Add scripts** under `scripts/` when the agent would otherwise reinvent the same logic. Scripts should:
   - Take all input via flags, env, or stdin (no interactive prompts)
   - Support `--help`
   - Print structured data on stdout and diagnostics on stderr
   - Fail with clear messages and stable exit codes

5. **Validate** (optional):

   ```bash
   # Reference validator from the Agent Skills project
   npx --yes skills-ref validate .
   # or, if installed:
   skills-ref validate .
   ```

6. **Install and try**

   ```bash
   # From another project, install this skill
   npx skills add <owner>/<repo>

   # Or scaffold a new skill elsewhere
   npx skills init my-skill
   ```

   Place project-local skills where your agent looks for them (common paths: `.agents/skills/`, `.claude/skills/`, `.grok/skills/`). See [agentskills.io](https://agentskills.io/) and your client docs.

## How progressive disclosure works

1. **Discovery** — agent loads only `name` + `description` for each skill.
2. **Activation** — on a matching task, it loads the full `SKILL.md` body.
3. **Execution** — it follows instructions and opens `scripts/`, `references/`, or `assets/` only as needed.

Point at reference files with triggers, not vague “see references/”:

```markdown
Read `references/REFERENCE.md` when the API returns a non-200 status.
```

## Description tips

Good descriptions say what the skill does and when to activate it, with concrete keywords:

```yaml
description: >
  Extract text and tables from PDF files, fill PDF forms, and merge PDFs.
  Use when working with PDF documents or when the user mentions PDFs, forms,
  or document extraction.
```

Avoid vague lines like “Helps with documents.”

## Writing tips

- Put domain facts, conventions, and gotchas the model would not know on its own.
- Give a default tool or approach; mention alternatives briefly.
- Use checklists for multi-step work and a validate-then-fix loop when outputs can be checked.
- Prefer relative paths from the skill root (`scripts/…`, `references/…`).
- Prefer one level of file references from `SKILL.md` (avoid deep chains).

More guidance: [Best practices](https://agentskills.io/skill-creation/best-practices), [Using scripts](https://agentskills.io/skill-creation/using-scripts), [Specification](https://agentskills.io/specification).

## Example scripts

```bash
chmod +x scripts/example.sh
bash scripts/example.sh --name Ada --format json
python3 scripts/example.py --name Ada --format json
```

Replace these samples with real helpers for your domain.

## Publish

- Push this repo and install with `npx skills add <owner>/<repo>`.
- Or host `SKILL.md` and add it by URL (see Skills CLI help: `npx skills --help`).
- Browse the ecosystem at [skills.sh](https://skills.sh/).

## Spec summary

From the [Agent Skills specification](https://agentskills.io/specification):

- Skill = directory with `SKILL.md` (YAML frontmatter + Markdown body).
- Required frontmatter: `name`, `description`.
- Optional directories: `scripts/`, `references/`, `assets/`, plus any others you need.
- `name` must match the parent directory name.

## License

MIT — see [LICENSE](LICENSE). Change the license field in `SKILL.md` if you use different terms.
