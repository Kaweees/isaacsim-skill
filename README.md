# isaacsim-skill

A collection of [Agent Skills](https://agentskills.io/) for NVIDIA Isaac Sim which covers how to build scenes, convert robots, run physics, navigate, render, collect synthetic data, bridge to ROS 2, and more.

## Install

Install with the [`skills` CLI](https://github.com/vercel-labs/skills).

Global install:

```sh
npx skills add kaweees/isaacsim-skill -g        # prompt to choose skills and agents
npx skills add kaweees/isaacsim-skill --all -g  # install every skill for every agent
```

Project install:

```sh
npx skills add kaweees/isaacsim-skill           # prompt to choose skills and agents
npx skills add kaweees/isaacsim-skill --all     # install every skill for every agent
```

## After install

1. Set the env vars used by the skills (see the [environment contract](skills/SKILLS.md#environment-contract)):

   | Variable | Purpose | Example |
   | --- | --- | --- |
   | `$ISAAC_SIM_DIR` | Isaac Sim install or build root | `$HOME/IsaacSim` |
   | `$ISAAC_LAB_DIR` | Isaac Lab root | `$ISAAC_SIM_DIR/IsaacLab` |
   | `$WORKSPACE_DIR` | Outputs and scratch space | project path or `~/.cache/isaacsim-skill` |

2. Start with the catalog: [skills/SKILLS.md](skills/SKILLS.md), then `isaac-sim-orchestrator`.

## Layout

```
.
├── README.md
├── LICENSE
├── skills/
│   ├── SKILLS.md            # Catalog and how skills compose
│   ├── isaac-sim-orchestrator/
│   ├── physics-simulation/
│   └── ...                  # One directory per skill (each has SKILL.md)
```

Each skill is a folder under `skills/` with a `SKILL.md` plus optional `scripts/` and `references/`. Format details: [agentskills.io specification](https://agentskills.io/specification).

## License

MIT. See [LICENSE](LICENSE).
