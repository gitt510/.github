# .github

Shared GitHub Actions configuration for this account.

## `deploy-worker`

Builds and deploys a Cloudflare Worker. Install, test, asset build, and upload
run in that order, so a failing test stops the deploy and the Worker never
uploads assets that were not rebuilt.

```yaml
jobs:
  deploy:
    uses: gitt510/.github/.github/workflows/deploy-worker.yml@v1
    with:
      worker-dir: apps/api          # default: repository root
      web-filter: '@mybibles/web'   # default: no asset build
    secrets:
      CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
```

| Input | Meaning |
| --- | --- |
| `worker-dir` | Directory holding the wrangler configuration. `wrangler deploy` runs here. |
| `web-filter` | pnpm filter for the browser asset build. Empty skips the build. |

The node version comes from the calling repository's `mise.toml`, so local
shells and CI read one file.

No account id is passed. An account-owned Cloudflare token is bound to one
account, so wrangler resolves the account from the token itself.

Secrets belong to the calling repository. This repository stores no
credentials; the `secrets` block above is a requirement, not a store. Callers
name the secret explicitly rather than using `inherit`, so a change here
cannot reach an unrelated secret.

Pin the version with a tag. `@main` would let a later change to this
repository read the caller's Cloudflare token.
