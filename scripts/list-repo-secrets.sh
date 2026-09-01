#!/usr/bin/env bash
# List Actions secrets across every non-archived repository of the account.
# Output: <repo> TAB <secret name> TAB <updated YYYY-MM-DD>
# Repos without secrets produce no rows.
set -euo pipefail

gh repo list gitt510 --no-archived --limit 200 --json name -q '.[].name' |
  xargs -P 12 -I {} gh secret list -R "gitt510/{}" --json name,updatedAt \
    --jq '.[] | ["{}", .name, .updatedAt[:10]] | @tsv' |
  sort
