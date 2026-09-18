# .github

Shared GitHub Actions configuration for this account.


## Workflows

| workflow | when | what |
|---|---|---|
| `deploy-worker-pnpm` | caller's push to main | `wrangler deploy` — production |
| `preview-worker-pnpm` | caller's `pull_request` | `wrangler versions upload` — preview URL recorded as a GitHub Deployment in environment `pr-<n>`, marked inactive when the PR closes. No PR comments. |
