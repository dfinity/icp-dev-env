# ICP Developer Environment

Docker images for ICP canister development, designed for use with GitHub Codespaces and local dev containers.

## Images

### `icp-dev-env-motoko`

For Motoko canister development.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 1.4.0 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.11.1 |
| [mops](https://mops.one) | 3.2.0 |
| moc | pinned per-project via `mops.toml` (`mops toolchain use moc <version>`) |
| [yq](https://github.com/mikefarah/yq) | 4.53.6 |
| Node.js | 24.20.0 |
| pnpm | 11.25.0 |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-motoko:latest   # always current
docker pull ghcr.io/dfinity/icp-dev-env-motoko:2.1.0    # pinned
```

### `icp-dev-env-rust`

For Rust canister development.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 1.4.0 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.11.1 |
| [candid-extractor](https://github.com/dfinity/cdk-rs) | 0.1.6 |
| [yq](https://github.com/mikefarah/yq) | 4.53.6 |
| Rust | 1.98.0 |
| wasm32-unknown-unknown target | — |
| Node.js | 24.20.0 |
| pnpm | 11.25.0 |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-rust:latest   # always current
docker pull ghcr.io/dfinity/icp-dev-env-rust:2.1.0    # pinned
```

### `icp-dev-env-all`

Combined Motoko and Rust development environment. Use this when your project includes both Motoko and Rust canisters.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 1.4.0 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.11.1 |
| [candid-extractor](https://github.com/dfinity/cdk-rs) | 0.1.6 |
| [mops](https://mops.one) | 3.2.0 |
| moc | pinned per-project via `mops.toml` (`mops toolchain use moc <version>`) |
| [yq](https://github.com/mikefarah/yq) | 4.53.6 |
| Rust | 1.98.0 |
| wasm32-unknown-unknown target | — |
| Node.js | 24.20.0 |
| pnpm | 11.25.0 |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-all:latest   # always current
docker pull ghcr.io/dfinity/icp-dev-env-all:2.1.0    # pinned
```

## Usage

Reference the image in your `.devcontainer/devcontainer.json`:

```json
{
  "name": "My Example (Motoko)",
  "image": "ghcr.io/dfinity/icp-dev-env-motoko:latest",
  "workspaceFolder": "/workspaces/examples/motoko/my-example",
  "forwardPorts": [8000],
  "portsAttributes": {
    "8000": { "label": "ICP local network", "onAutoForward": "ignore" }
  },
  "postCreateCommand": "mops install",
  "postStartCommand": "icp network start -d",
  "customizations": {
    "vscode": {
      "extensions": ["dfinity-foundation.vscode-motoko", "stateful.runme"]
    }
  }
}
```

See [dfinity/examples](https://github.com/dfinity/examples) for full usage across all examples.

## Releasing

Tool versions are pinned via `ARG` in each Dockerfile. To update a version:

1. Update the relevant `ARG` in the affected Dockerfile(s) (`motoko/Dockerfile`, `rust/Dockerfile`, `all/Dockerfile`)
2. Update the version tables and pinned pull examples above
3. Create a new GitHub Release with a semver tag (e.g. `v2.0.0`) — the CI pipeline builds and pushes all images to GHCR

### Versioning

Image versions are independent of the versions of the tools they ship. The number
describes the image's compatibility surface for the projects that use it:

| Bump | When |
|---|---|
| **MAJOR** | A pinned tool changes in a way that can break existing projects (e.g. mops 2.x → 3.x) |
| **MINOR** | Backward-compatible tool upgrades, or a new tool added to an image |
| **PATCH** | Rebuilds, base-image security updates, tool patches with no user-visible effect |

Up to `v1.3.0` the image version mirrored the `icp-cli` version it shipped. That
coupling ended at `v2.0.0`: a release may now bump the image's major without
`icp-cli` moving at all, and vice versa. Consult the version tables above for the
`icp-cli` version in a given image.

Images are built for `linux/amd64` and `linux/arm64`.

> **Note:** The release must be published as non-draft to trigger the CI pipeline.
