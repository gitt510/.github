# .github

Shared GitHub Actions configuration for this account.

## `deploy-worker-pnpm`

Builds and deploys a Cloudflare Worker from a pnpm workspace. Asset build and
upload run in that order, so the Worker never uploads assets that were not
rebuilt.

```yaml
jobs:
  deploy:
    uses: gitt510/.github/.github/workflows/deploy-worker-pnpm.yml@v2
    with:
      working-directory: apps/api    # default: repository root
      assets-package: '@myrepo/web'  # default: no asset build
    secrets:
      CLOUDFLARE_API_TOKEN: ${{ secrets.CLOUDFLARE_API_TOKEN }}
```

| Input | Meaning |
| --- | --- |
| `working-directory` | Directory holding the wrangler configuration. `wrangler deploy` runs here. |
| `assets-package` | pnpm workspace package (the `name` in its package.json) whose `build` script produces the Worker's static assets. Empty skips the build. |

This workflow deploys; it does not test. Gate merges with PR CI and branch
protection, or put a `test` job with `needs:` in the calling workflow.

The calling repository must be a pnpm workspace — the file name carries that
assumption — and must hold a `mise.toml` declaring its node version, so local
shells and CI read one file.

No account id is passed. An account-owned Cloudflare token is bound to one
account, so wrangler resolves the account from the token itself.

Secrets belong to the calling repository. This repository stores no
credentials; the `secrets` block above is a requirement, not a store. Callers
name the secret explicitly rather than using `inherit`, so a change here
cannot reach an unrelated secret.

Pin the version with a tag. `@main` would let a later change to this
repository read the caller's Cloudflare token. `v1` (the former
`deploy-worker.yml`) stays valid for existing callers.
