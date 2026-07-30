#!/usr/bin/env python3
"""Example skill script — replace with real helpers.

Agent-friendly design:
  - CLI flags only (no interactive input)
  - --help documents the interface
  - Structured output on stdout; logs on stderr
  - Distinct exit codes and actionable errors
"""

from __future__ import annotations

import argparse
import json
import sys


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="scripts/example.py",
        description="Example helper bundled with an Agent Skill.",
    )
    parser.add_argument("--name", default="world", help="Name to greet (default: world)")
    parser.add_argument(
        "--format",
        choices=("text", "json"),
        default="text",
        help="Output format (default: text)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Print planned action without producing the greeting",
    )
    return parser


def main(argv: list[str] | None = None) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.dry_run:
        print(
            f"dry-run: would greet name={args.name} format={args.format}",
            file=sys.stderr,
        )
        return 0

    if args.format == "json":
        print(json.dumps({"message": f"Hello, {args.name}", "ok": True}))
    else:
        print(f"Hello, {args.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
