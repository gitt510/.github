#!/usr/bin/env bash
# List which reusable workflow in this repo is referenced by which local ghq clone.
# Output: <workflow file> TAB <consumer file>
# MVP: local grep only — repos not cloned under ghq are invisible.
set -euo pipefail

ref='gitt510/\.github/\.github/workflows/[A-Za-z0-9._-]+\.ya?ml'
root="$(ghq root)"
self="$root/github.com/gitt510/.github"

# Workflow files live at a fixed depth (<host>/<owner>/<repo>/.github/workflows),
# so glob them directly instead of walking the whole ghq root.
shopt -s nullglob
files=("$root"/*/*/*/.github/workflows/*.yml "$root"/*/*/*/.github/workflows/*.yaml)
[ ${#files[@]} -eq 0 ] && exit 0

grep -HoE "$ref" "${files[@]}" 2>/dev/null |
  grep -v "^$self/" |
  sed -E "s|^$root/(.+):.*workflows/(.+)$|\2\t\1|" |
  sort -u
