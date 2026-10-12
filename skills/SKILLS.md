# Isaac Sim Skills Index

Platform-neutral inventory of agent skills in this repository. Both
`AGENTS.md` (Cursor / Codex CLI / other AGENTS.md-aware tools) and `CLAUDE.md`
(Claude Code) point here.

Legacy `.claude/skills/` and `.cursor/skills/` are retired; everything lives
under `skills/`.

A skill is a directory with a `SKILL.md` (YAML frontmatter for auto-loading)
plus optional `scripts/`, `references/`, and `evals/`. Skills are
content-addressable by the descriptions below.

---

## Library layers

| Layer | Purpose | Source |
|---|---|---|
| Repo-native tools | Control, profile, and validate a built Isaac Sim | Authored against the Isaac Sim source tree |
| Robotics-sim | Install, build, render, validate Isaac Sim simulations as a downstream user | Imported from the isaac-claw library |
| Action & Event Data Generation (AEDG) | Actor, object, incident, camera, and caption SDG | Drives the AEDG extension stack (IRA, IRO, IRI, IRC, ISP, ISC) |

Repo-native skills use an Isaac Sim release build, benchmark outputs, or the
`python_server` socket. Robotics-sim skills drive a built Isaac Sim from a
script (`SimulationApp`, `isaacsim.core.experimental.*`, USD authoring). AEDG
skills run inside the AEDG app (`isaac-sim.action_and_event_data_generation.sh`).

---

## Quick index

- [Repo-native public skills](#repo-native-public-skills) — remote-control, profile, validate
- [Setup & environment](#setup--environment) — install, assets, migration
- [Foundations & operating loop](#foundations--operating-loop) — what every robotics-sim session loads
- [Robot asset pipeline](#robot-asset-pipeline) — URDF → USD
- [Physics simulation](#physics-simulation) — PhysX, Newton, contact, joints
- [Mobile robot navigation](#mobile-robot-navigation) — runtime nav, SDG
- [Manipulation & motion](#manipulation--motion) — IK, grasp, motion generation
- [Sensors & cameras](#sensors--cameras) — camera, LiDAR, IMU, placement, calibration
- [Synthetic data generation](#synthetic-data-generation) — Replicator, MobilityGen, bin packing, captions
- [Action & event data generation](#action--event-data-generation) — actors, incidents, behavior trees
- [Rendering & lighting](#rendering--lighting) — RT2 production rendering
- [USD pipeline](#usd-pipeline) — composition, scaling, material binding
- [ROS 2 integration](#ros-2-integration) — Nav2, multi-robot bridges, workspaces
- [How the library composes](#how-the-library-composes) — pipeline diagrams

---

## Repo-native public skills

Operate on an Isaac Sim build or its benchmark outputs. Shipped in published packages.

| Skill | What it does |
|---|---|
| [`isaac-sim-remote`](isaac-sim-remote/SKILL.md) | Drive a running Isaac Sim instance over the loopback `python_server` socket (`127.0.0.1:8226`): run code, open stages, inspect/modify prims, screenshots and viewport video, step physics, verify assets, read console logs, shut down. Works headless. |
| [`profile-isaac-sim`](profile-isaac-sim/SKILL.md) | Profile and optimize Isaac Sim with the in-repo benchmark scripts and Tracy. Compare runs, diff frame times, isolate hot zones. |
| [`validation-diff-gifs`](validation-diff-gifs/SKILL.md) | Build pixel-diff GIFs comparing a validation capture run against its golden data — fastest way to triage benchmark or SDG-tolerance image failures. |

---

## Setup & environment

Get Isaac Sim installed, reach its assets, and move between releases.

| Skill | What it does |
|---|---|
| [`isaac-sim-installation`](isaac-sim-installation/SKILL.md) | Install from a public standalone build, Docker image, or Python package behind preflight, compatibility, EULA, and `--execute` gates. Never launches the app. |
| [`isaac-sim-assets`](isaac-sim-assets/SKILL.md) | Asset access: Asset Region Profiles, custom/local asset roots, downloadable asset packs, availability manifests, asset-root precedence. For missing or unreachable assets and offline setups. |
| [`isaac-sim-migration`](isaac-sim-migration/SKILL.md) | Audit and validate release migrations (currently 5.1 → 6.0). Not for new-project setup. |

---

## Foundations & operating loop

Entry point, validation, and troubleshooting for robotics-sim sessions.

| Skill | What it does |
|---|---|
| [`isaac-sim-workflow`](isaac-sim-workflow/SKILL.md) | Scope demos, POCs, and presentation captures before implementation: deliverable type, acceptance criteria, evidence, specialist handoffs. Load before `isaac-sim-orchestrator` for demo requests. |
| [`isaac-sim-orchestrator`](isaac-sim-orchestrator/SKILL.md) | Executes end-to-end work through ordered specialist skills and validation. Declares the env-var contract every other skill assumes (`$ISAAC_SIM_DIR`, `$ISAAC_LAB_DIR`, `$WORKSPACE_DIR`, `$CIP_ROOT`). Multi-robot fleet reference and Physical AI pipeline route chain. |
| [`isaac-sim-validator`](isaac-sim-validator/SKILL.md) | Final QA gate before delivery: rejects black frames, hardcoded user paths, deprecated `omni.isaac.core` imports, missing lights, mounting bugs. Level 3 executes the script unsandboxed and requires `--confirm-execute`. |
| [`isaac-sim-troubleshooting`](isaac-sim-troubleshooting/SKILL.md) | Hang/freeze/perf reference — startup hangs, MDL freezes, physics stepping hangs, Replicator hangs, Hydra issues. |

---

## Robot asset pipeline

URDF/MJCF/CAD → sim-ready USD asset.

| Skill | What it does |
|---|---|
| [`urdf-mjcf-to-usd-conversion`](urdf-mjcf-to-usd-conversion/SKILL.md) | URDF/MJCF → USD for Isaac Sim & Isaac Lab. `config.yaml` schema, `make_instanceable`, RL vs teleop drives, instanceable meshes. XACRO must be pre-expanded. Every new robot starts here. |
| [`usd-articulation`](usd-articulation/SKILL.md) | Multi-link / multi-arm articulation validation. `ArticulationRootAPI`, `FixedJoint`, flatten-before-deploy. |

---

## Physics simulation

Single source of truth for physics scene config and per-prim setup.

| Skill | What it does |
|---|---|
| [`physics-simulation`](physics-simulation/SKILL.md) | PhysicsScene/Hz/CCD/stabilization, RigidBodyAPI/MassAPI/CollisionAPI/kinematic, contact materials, joint drives, Newton solver selection (Featherstone/MuJoCo/XPBD/SemiImplicit/VBD) vs PhysX, physics sensors (contact/IMU/raycast), `RigidPrim` vs `XformCache` readback. Includes worked examples (impact/crash, vibratory feeder, domino cascade, spinning top, Newton's cradle, pendulum wave, escapement). |

---

## Mobile robot navigation

Shared substrate plus runtime / SDG specializations.

| Skill | What it does |
|---|---|
| [`navigation-primitives`](navigation-primitives/SKILL.md) | Shared substrate: `OccupancyMap`, A* planner, robot footprints (Spot Z=0.69, Carter, VSVXL, Jetbot, Kaya, H1), differential/holonomic kinematics, look-at chase camera math. Read FIRST. |
| [`occupancy-map`](occupancy-map/SKILL.md) | Generate ROS-compatible `map.yaml` from USD warehouses for Nav2 / MobilityGen / A*. |
| [`isaac-sim-robot-navigation`](isaac-sim-robot-navigation/SKILL.md) | Runtime nav in custom scripts: RL policy, physics-vs-baked-vs-per-frame, GPU OOM avoidance, Kit gotchas. |
| [`mobility-gen`](mobility-gen/SKILL.md) | Two-phase SDG: record trajectories (physics) → replay + render (sensors). Custom `MobilityGenRobot` subclassing. |

---

## Manipulation & motion

| Skill | What it does |
|---|---|
| [`manipulation-ik`](manipulation-ik/SKILL.md) | Differential IK (damped least-squares), grasp frames, `FixedJoint` grasping, hybrid IK + joint-space, contact validation. |
| [`motion-generation`](motion-generation/SKILL.md) | Obstacle-aware motion-generation controllers for arms and mobile bases, driven by `SceneQuery` for end-effector or drive targets. |

---

## Sensors & cameras

| Skill | What it does |
|---|---|
| [`isaac-sim-sensor`](isaac-sim-sensor/SKILL.md) | RTX and physics sensor suite: RGB/depth/seg/optical-flow, LiDAR, IMU, contact, ultrasonic, DR. Vendor LiDAR/radar/acoustic catalog (`SUPPORTED_LIDAR_CONFIGS`: Ouster, Hesai, Velodyne, Robosense, SICK, Zvision, NVIDIA), USDA mount attachment, custom emitter-state scan-pattern authoring. |
| [`isaac-camera`](isaac-camera/SKILL.md) | `UsdGeomCamera` setup, render products, intrinsics, AOVs, OpenCV/fisheye distortion. |
| [`place-camera-aim-at`](place-camera-aim-at/SKILL.md) | Occlusion-aware `CircularCameraPlacement` around one target prim or world point — multi-angle product or robot inspection shots. |
| [`place-camera-max-coverage`](place-camera-max-coverage/SKILL.md) | Greedy `CameraPlacementManager` that fills a navmesh or XY scope until a patch-coverage ratio is met — surveillance layouts with minimal camera count. |
| [`calibrate-metropolis-camera`](calibrate-metropolis-camera/SKILL.md) | Extract camera intrinsics, extrinsics, and FOV polygons to `calibration.json`. Run after cameras are placed. |

---

## Synthetic data generation

| Skill | What it does |
|---|---|
| [`data-collection-sim`](data-collection-sim/SKILL.md) | Static-scene headless Replicator SDG: `BasicWriter`, `PoseWriter`, `KittiWriter`, shelf pose-grid capture, production capture QA. Sibling of `mobility-gen` (mobile-robot SDG). |
| [`mobility-gen`](mobility-gen/SKILL.md) | (See [Mobile robot navigation](#mobile-robot-navigation).) |
| [`object-bin-packing`](object-bin-packing/SKILL.md) | Pack boxes/parcels into a bin, pallet, or container and render SDG with IRO's `bin_pack` harmonizer. |
| [`vlm-scene-captioning`](vlm-scene-captioning/SKILL.md) | Image + caption pairs and structured scene graphs (IRC, `isaacsim.replicator.caption.core`) for VLM training; wires IRC into actor/object SDG runs. |

---

## Action & event data generation

SDG with moving actors, physical incidents, and behaviors. Start at
`action-and-event-data-generation`, which routes to the rest and carries the
shared launcher, extension stack, and config `version` rules.

| Skill | What it does |
|---|---|
| [`action-and-event-data-generation`](action-and-event-data-generation/SKILL.md) | AEDG entry point: routes actor / object / incident / camera / caption requests, documents the extension stack (IRA, IRO, IRI, IRC, ISP, ISC, behavior-tree gen, IAR) and how stages compose. |
| [`actor-sdg-sweep-config`](actor-sdg-sweep-config/SKILL.md) | Generate validated Isaac Sim Replicator Agent (IRA) YAML variations and optionally batch-run Actor SDG. |
| [`actor-sdg-generate-lighting-variations`](actor-sdg-generate-lighting-variations/SKILL.md) | Deterministic USD lighting-override sublayers for Actor SDG (IRA `prop_asset_paths`). |
| [`generate-incident-config`](generate-incident-config/SKILL.md) | Author and validate the IRI event config YAML for topple, fire, and spill incidents. |
| [`run-incident-events`](run-incident-events/SKILL.md) | Tag prims and drive IRI incidents on a live stage, then record a report. |
| [`behavior-tree-generation`](behavior-tree-generation/SKILL.md) | LLM-driven behavior-tree generation: natural-language scenario → behavior-tree files, context/schema authoring, planner scripting. Needs `$NVIDIA_API_KEY`. |

---

## Rendering & lighting

| Skill | What it does |
|---|---|
| [`isaac-sim-rendering`](isaac-sim-rendering/SKILL.md) | Headless production rendering: SimulationApp + Replicator capture, RT2 vs PathTracing, ACES tone mapping (`filmIso` 200/400/600), multi-layer warehouse lighting, deep-aisle solutions, validation thresholds. |
| [`isaac-sim-headless-deployment`](isaac-sim-headless-deployment/SKILL.md) | Headless `--no-window` Isaac Sim 6 with the renderer disabled: launch modes, CLI flags, `SimulationApp` batch pattern, physics-only CI, perf tuning. |

---

## USD pipeline

| Skill | What it does |
|---|---|
| [`spatial-reasoning`](spatial-reasoning/SKILL.md) | Transform math cornerstone: mpu, bbox, T·R·S ordering, look-at, collision-free grids, A*, Dubins, R-tree, 2D bin packing, OSHA/NFPA/RMI standards. |
| [`usd-pipeline`](usd-pipeline/SKILL.md) | Asset discovery, bbox/shader measurement, placeholder-to-asset placement, headless render compatibility (MDL vs UsdPreviewSurface). |
| [`usd-composition-architecture`](usd-composition-architecture/SKILL.md) | NVIDIA-style layered USD (root + physics + appearance payloads). Skip appearance for load-time optimization. |

---

## ROS 2 integration

| Skill | What it does |
|---|---|
| [`isaac-sim-ros2-bridge`](isaac-sim-ros2-bridge/SKILL.md) | OmniGraph ROS 2 nodes (current `isaacsim.ros2.bridge.*` namespace), Nav2 integration, multi-robot namespacing, prerequisites. |
| [`isaac-sim-ros-workspaces`](isaac-sim-ros-workspaces/SKILL.md) | Clone, configure, or build `IsaacSim-ros_workspaces` via native ROS, Docker, custom interfaces, or Pixi. |

---

## Environment contract

All robotics-sim and AEDG skills assume these shell variables (set in your
agent config or shell profile). Skills reference them rather than hardcode paths:

| Variable | Purpose | Example |
|---|---|---|
| `$ISAAC_SIM_DIR` | Isaac Sim install root or built repo path | `$HOME/IsaacSim` (install) or `<this-repo>/_build/linux-x86_64/release` (source build) |
| `$ISAAC_LAB_DIR` | Isaac Lab checkout root | `$ISAAC_SIM_DIR/IsaacLab` |
| `$WORKSPACE_DIR` | Per-agent workspace (outputs, scratch, caches) | unset by default — pick a project-local path or `~/.cache/<repo>` |
| `$CIP_ROOT` (Windows) | Content-pipeline install (CIP/WRAPP skills, not currently imported) | `C:\_Data` |
| `$NVIDIA_API_KEY` | LLM-backed AEDG features only (captioning, behavior-tree generation) | — |

---

## How the library composes

Pipeline diagrams for the major skill chains. Use at the orient step to find
the entry point.

### Core robotics simulation pipeline

```
isaac-sim-installation  ─►  isaac-sim-assets
       │
       ▼
URDF / MJCF / CAD source
       │
       ▼
urdf-mjcf-to-usd-conversion
       │
       ▼
usd-articulation        ◄──── usd-composition-architecture
(validate joints)              (root + physics + appearance layers)
       │
       ▼
physics-simulation
       │
       ▼
isaac-sim-orchestrator    →    isaac-sim-sensor
       │
       ▼
       data-collection-sim (SDG)
                │
                ▼
        mobility-gen (mobile-robot variant)
```

### Mobile robot navigation

```
                       navigation-primitives
                  (omap, A*, kinematics, robot footprints, camera math)
                              │
              ┌───────────────┴───────────────┐
              ▼                               ▼
   isaac-sim-robot-navigation         mobility-gen
   (live RL/baked/per-frame nav)      (record → replay SDG)
              │                               │
              └───────────────┬───────────────┘
                              ▼
              occupancy-map (map.yaml)
                              │
                              ▼
              isaac-sim-ros2-bridge (Nav2 integration)
```

### Action & event data generation

```
action-and-event-data-generation (entry / router)
       │
       ▼
object-bin-packing (IRO)                     ← static scene, procedural placement
       │
       ├── generate-incident-config → run-incident-events (IRI)
       └── actor-sdg-sweep-config (IRA)      ← people + robots with behaviors
             ├── actor-sdg-generate-lighting-variations
             └── behavior-tree-generation
                    │
                    ▼
place-camera-aim-at / place-camera-max-coverage (ISP)
                    │                        (skip if the IRA config places cameras)
                    ▼
calibrate-metropolis-camera (ISC)
                    │
                    ▼
vlm-scene-captioning (IRC)
```

### Rendering & validation pipeline

```
isaac-sim-rendering (RT2 + ACES production)
       │
       ▼
isaac-sim-validator (final QA gate)
```

---

## Robotics-sim skills (read order)

Read in this order if you can only load a slice.

| # | Skill | What it gives you |
|---|---|---|
| 1 | [`isaac-sim-orchestrator`](isaac-sim-orchestrator/SKILL.md) | Ordered multi-skill execution; declares the env-var contract every other skill assumes |
| 2 | [`isaac-sim-workflow`](isaac-sim-workflow/SKILL.md) | Scope demos/POCs before building |
| 3 | [`urdf-mjcf-to-usd-conversion`](urdf-mjcf-to-usd-conversion/SKILL.md) | Bring any robot from URDF/MJCF into Isaac Sim (pre-expand XACRO) |
| 4 | [`usd-articulation`](usd-articulation/SKILL.md) | Validate and assemble multi-link/multi-arm articulations |
| 5 | [`physics-simulation`](physics-simulation/SKILL.md) | Single source of truth for physics scene + per-prim setup |
| 6 | [`navigation-primitives`](navigation-primitives/SKILL.md) | Shared substrate for all mobile-robot work |
| 7 | [`data-collection-sim`](data-collection-sim/SKILL.md) | Static-scene Replicator SDG |
| 8 | [`mobility-gen`](mobility-gen/SKILL.md) | Mobile-robot SDG (record → replay + render) |
| 9 | [`isaac-sim-robot-navigation`](isaac-sim-robot-navigation/SKILL.md) | Runtime navigation in your own scripts |
| 10 | [`isaac-sim-sensor`](isaac-sim-sensor/SKILL.md) | Sensor primitives for SDG; vendor LiDAR/radar/acoustic catalog + USDA scan patterns |
| 11 | [`isaac-sim-rendering`](isaac-sim-rendering/SKILL.md) | Headless production rendering |
| 12 | [`isaac-sim-headless-deployment`](isaac-sim-headless-deployment/SKILL.md) | `--no-window` launch modes and `SimulationApp` batch pattern |
| 13 | [`isaac-sim-troubleshooting`](isaac-sim-troubleshooting/SKILL.md) | Hang/freeze/perf reference |
| 14 | [`isaac-sim-ros2-bridge`](isaac-sim-ros2-bridge/SKILL.md) | OmniGraph ROS 2 nodes, Nav2 integration |
| 15 | [`spatial-reasoning`](spatial-reasoning/SKILL.md) | Transform math cornerstone |
| 16 | [`manipulation-ik`](manipulation-ik/SKILL.md) | Differential IK, grasp frames, `FixedJoint` grasping |
| 17 | [`motion-generation`](motion-generation/SKILL.md) | Obstacle-aware arm and mobile-base controllers |
| 18 | [`isaac-camera`](isaac-camera/SKILL.md) | `UsdGeomCamera` setup, intrinsics, AOVs, distortion |
| 19 | [`usd-pipeline`](usd-pipeline/SKILL.md) | USD asset discovery, bbox/shader measurement, headless compatibility |
| 20 | [`usd-composition-architecture`](usd-composition-architecture/SKILL.md) | NVIDIA's layered USD pattern |
| 21 | [`isaac-sim-validator`](isaac-sim-validator/SKILL.md) | Final QA gate before delivery |
| 22 | [`occupancy-map`](occupancy-map/SKILL.md) | Generate ROS-compatible occupancy maps from USD warehouses |

---

## When stuck

- [`isaac-sim-troubleshooting`](isaac-sim-troubleshooting/SKILL.md) — hang / freeze / perf issues
- [`isaac-sim-assets`](isaac-sim-assets/SKILL.md) — missing or unreachable assets
- [`isaac-sim-migration`](isaac-sim-migration/SKILL.md) — breakage after a release upgrade
- [`isaac-sim-validator`](isaac-sim-validator/SKILL.md) — refuses bad deliverables before they reach the user

---

## How to navigate

- **New to this repo?** Start with the [Quick index](#quick-index) to find the relevant skill.
- **Installing Isaac Sim?** → [Setup & environment](#setup--environment).
- **Building a demo or POC?** → `isaac-sim-workflow` → `isaac-sim-orchestrator`.
- **Starting a new sim task?** → `isaac-sim-orchestrator` → match capability to the category tables above.
- **Bringing in a new robot?** → [Robot asset pipeline](#robot-asset-pipeline) → [Physics simulation](#physics-simulation).
- **Generating synthetic data?** → [Synthetic data generation](#synthetic-data-generation); with people, robots, or incidents → [Action & event data generation](#action--event-data-generation).
- **Rendering?** → `isaac-sim-rendering` is the source of truth.
- **Stuck?** → [When stuck](#when-stuck).

---

*Library size: 40 skills.*
