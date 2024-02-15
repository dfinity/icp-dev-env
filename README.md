# ICP Developer Environment

This repo contains Docker images that are used for setting up a remote, hybrid or local development environments for new developers on the Internet Computer.

## Usage
These container images can be used as a base for creating a dev container environment that targets ICP development.
Take a look at the repositories below to see dev containers in action:
- [ICP Hello World Motoko](https://github.com/dfinity/icp-hello-world-motoko)
- [ICP Hello World Rust](https://github.com/dfinity/icp-hello-world-rust)
- [ICP Azle 201 from dacadeorg](https://github.com/dacadeorg/icp-azle-201)
- [ICP Message Board Contract from dacadeorg](https://github.com/dacadeorg/icp-message-board-contract)

### Packages and Releases 
On the right side, you will find new releases and the latest packages.
You can download the Docker image for Rust/Motoko with 

```bash
docker pull ghcr.io/dfinity/icp-dev-env:latest
```

or the one for [Azle](https://github.com/demergent-labs/azle) (TypeScript and JavaScript) with

```bash
docker pull ghcr.io/dfinity/icp-dev-env-azle:latest
```

To download a specific version, add `:<version>` at the end instead of `:latest`.

## Creating a new Release
To release a new version of both images, create a new tag with the corresponding version number.
The CI pipeline will automatically build and push the new image to the GitHub Container Registry (ghcr.io).
