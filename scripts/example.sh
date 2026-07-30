#!/usr/bin/env bash
# Example skill script — replace with real helpers.
# Design rules for agent-friendly scripts:
#   - No interactive prompts
#   - Document usage with --help
#   - Structured data on stdout; diagnostics on stderr
#   - Clear errors and meaningful exit codes
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scripts/example.sh [OPTIONS]

Example helper bundled with an Agent Skill.

Options:
  --name NAME     Name to greet (default: world)
  --format FMT    Output format: text|json (default: text)
  --dry-run       Print planned action without side effects
  -h, --help      Show this help

Exit codes:
  0  Success
  1  Invalid arguments
  2  Runtime failure

Examples:
  scripts/example.sh --name Alice
  scripts/example.sh --name Alice --format json
EOF
}

NAME="world"
FORMAT="text"
DRY_RUN=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --name)
      [[ $# -ge 2 ]] || { echo "Error: --name requires a value" >&2; exit 1; }
      NAME="$2"
      shift 2
      ;;
    --format)
      [[ $# -ge 2 ]] || { echo "Error: --format requires a value" >&2; exit 1; }
      FORMAT="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option: $1" >&2
      echo "Run with --help for usage." >&2
      exit 1
      ;;
  esac
done

case "$FORMAT" in
  text|json) ;;
  *)
    echo "Error: --format must be one of: text, json." >&2
    echo "       Received: \"$FORMAT\"" >&2
    exit 1
    ;;
esac

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "dry-run: would greet name=$NAME format=$FORMAT" >&2
  exit 0
fi

if [[ "$FORMAT" == "json" ]]; then
  printf '{"message":"Hello, %s","ok":true}\n' "$NAME"
else
  printf 'Hello, %s\n' "$NAME"
fi
