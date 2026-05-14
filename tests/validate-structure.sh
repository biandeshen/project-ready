#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
errors=0

red()   { printf "\033[31m%s\033[0m\n" "$1"; }
green() { printf "\033[32m%s\033[0m\n" "$1"; }

check_file() {
  if [ -f "$ROOT/$1" ]; then echo "  ✅ $1"
  else red "  ❌ MISSING: $1"; errors=$((errors + 1)); fi
}

check_dir() {
  if [ -d "$ROOT/$1" ]; then echo "  ✅ $1/"
  else red "  ❌ MISSING: $1/"; errors=$((errors + 1)); fi
}

echo "=== Directory structure ==="
for dir in src/roles src/rounds src/templates src/archetypes installer tests docs; do
  check_dir "$dir"
done

echo "=== Role files ==="
for r in 01-architect 02-quality 03-devops 04-security 05-developer-experience 06-reset-perspective; do
  check_file "src/roles/$r.md"
done

echo "=== Round files ==="
for r in 01-architecture-baseline 02-testing-strategy 03-toolchain 04-git-workflow 05-cicd 06-security-baseline 07-documentation 08-monitoring; do
  check_file "src/rounds/$r.md"
done

echo "=== Template files ==="
for t in project-profile round-output decision-document; do
  check_file "src/templates/$t.md"
done

echo "=== Core files ==="
for f in playbook.md README.md LICENSE .editorconfig .gitignore; do
  check_file "$f"
done

echo "=== Archetype JSONs ==="
for arch in "$ROOT/src/archetypes/"*.json; do
  name=$(basename "$arch")
  if python3 -m json.tool "$arch" > /dev/null 2>&1; then
    invalid_ref=false
    # Cross-reference check: extract round refs with Python, check with Shell
    refs=$(python3 -c "
import json
with open('$arch') as f:
    data = json.load(f)
for r in data.get('recommendations', {}).get('rounds', []):
    print(r)
" 2>/dev/null) || true
    invalid=false
    for round_ref in $refs; do
      rn="${round_ref#R}"
      found=false
      for f in "$ROOT/src/rounds/$rn-"*.md; do
        [ -f "$f" ] && found=true && break
      done
      if [ "$found" = false ]; then
        echo "  ❌ $name refs '$round_ref' but no src/rounds/${rn}-*.md"
        invalid=true
        errors=$((errors + 1))
      fi
    done
    [ "$invalid" = false ] && echo "  ✅ $name"
    [ "$invalid_ref" = false ] && echo "  ✅ $name"
  else
    red "  ❌ $name (INVALID JSON)"
    errors=$((errors + 1))
  fi
done

echo ""
if [ $errors -eq 0 ]; then green "✅ All structures valid"
else red "❌ $errors error(s) found"; exit 1; fi
