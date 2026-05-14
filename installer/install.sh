#!/usr/bin/env bash
set -euo pipefail

# Project Readiness Council — Installer
# Usage: bash installer/install.sh /path/to/target-project

FRAMEWORK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TARGET_DIR="${1:-}"

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: bash installer/install.sh /path/to/target-project"
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Target directory '$TARGET_DIR' does not exist."
  exit 1
fi

CLAUDE_DIR="$TARGET_DIR/.claude"
READINESS_DIR="$CLAUDE_DIR/readiness"

mkdir -p "$READINESS_DIR"
mkdir -p "$READINESS_DIR/outputs"

# Copy core files
cp "$FRAMEWORK_DIR/playbook.md" "$READINESS_DIR/"
cp -r "$FRAMEWORK_DIR/src/roles" "$READINESS_DIR/"
cp -r "$FRAMEWORK_DIR/src/rounds" "$READINESS_DIR/"
cp -r "$FRAMEWORK_DIR/src/templates" "$READINESS_DIR/"
cp -r "$FRAMEWORK_DIR/src/archetypes" "$READINESS_DIR/"

echo "✅ Project Readiness Council installed to $READINESS_DIR"
echo ""
echo "To execute, run this in Claude Code:"
echo "  read .claude/readiness/playbook.md and execute it"
