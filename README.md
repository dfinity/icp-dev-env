# ICP Developer Environment

Docker images for ICP canister development, designed for use with GitHub Codespaces and local dev containers.

## Images

### `icp-dev-env-motoko`

For Motoko canister development.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 0.2.7 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.9.11 |
| [mops](https://mops.one) | 2.13.2 |
| moc | installed per-project via `mops install` |
| Node.js | 22.10.0 |
| pnpm | latest |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-motoko:latest
```

### `icp-dev-env-rust`

For Rust canister development.

| Tool | Version |
|---|---|
| [icp-cli](https://cli.internetcomputer.org) | 0.2.7 |
| [ic-wasm](https://github.com/dfinity/ic-wasm) | 0.9.11 |
| Rust | 1.89 |
| wasm32-unknown-unknown target | — |
| Node.js | 22.10.0 |
| pnpm | latest |

```bash
docker pull ghcr.io/dfinity/icp-dev-env-rust:latest
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

1. Update the relevant `ARG` in `motoko/Dockerfile` and/or `rust/Dockerfile`
2. Create a new GitHub release — the CI pipeline builds and pushes both images to GHCR

Images are built for `linux/amd64` and `linux/arm64`.
