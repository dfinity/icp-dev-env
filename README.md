# ICP Developer Environment

Docker images for ICP canister development, designed for use with GitHub Codespaces and local dev containers.

## Images

### `icp-dev-env-motoko`

For Motoko canister development.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 0.3.1 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.9.11 |
| [mops](https://mops.one) | 2.13.2 |
| moc | installed per-project via `mops install` |
| Node.js | 24.15.0 |
| pnpm | 11.4.0 |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-motoko:latest   # always current
docker pull ghcr.io/dfinity/icp-dev-env-motoko:0.3.1    # pinned
```

### `icp-dev-env-rust`

For Rust canister development.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 0.3.1 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.9.11 |
| Rust | 1.95.0 |
| wasm32-unknown-unknown target | — |
| Node.js | 24.15.0 |
| pnpm | 11.4.0 |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-rust:latest   # always current
docker pull ghcr.io/dfinity/icp-dev-env-rust:0.3.1    # pinned
```

### `icp-dev-env-all`

Combined Motoko and Rust development environment. Use this when your project includes both Motoko and Rust canisters.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 0.3.1 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.9.11 |
| [mops](https://mops.one) | 2.13.2 |
| moc | installed per-project via `mops install` |
| Rust | 1.95.0 |
| wasm32-unknown-unknown target | — |
| Node.js | 24.15.0 |
| pnpm | 11.4.0 |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-all:latest   # always current
docker pull ghcr.io/dfinity/icp-dev-env-all:0.3.1    # pinned
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
2. Create a new GitHub Release with a semver tag (e.g. `v1.0.1`) — the CI pipeline builds and pushes all images to GHCR

Images are built for `linux/amd64` and `linux/arm64`.

> **Note:** The release must be published as non-draft to trigger the CI pipeline.
