# isaacsim-skill

A collection of [Agent Skills](https://agentskills.io/) for NVIDIA Isaac Sim which covers how to build scenes, convert robots, run physics, navigate, render, collect synthetic data, bridge to ROS 2, and more.

## Install

Install with the [`skills` CLI](https://github.com/vercel-labs/skills). That is the standard way to install this skill.

Global install:

```sh
npx skills add kaweees/isaacsim-skill -g
```

Project install:

```sh
npx skills add kaweees/isaacsim-skill --project
```

## After install

1. Set the env vars the robotics skills expect (see [skills/SKILLS.md](skills/SKILLS.md)):

   | Variable | Purpose | Example |
   | --- | --- | --- |
   | `$ISAAC_SIM_DIR` | Isaac Sim install or build root | `$HOME/IsaacSim` |
   | `$ISAAC_LAB_DIR` | Isaac Lab root | `$ISAAC_SIM_DIR/IsaacLab` |
   | `$WORKSPACE_DIR` | Outputs and scratch space | project path or `~/.cache/isaacsim-skill` |

2. Start with the catalog and entry skills: [skills/SKILLS.md](skills/SKILLS.md), then `meta-skills` and `isaac-sim-orchestrator`.

## License

MIT. See [LICENSE](LICENSE).
