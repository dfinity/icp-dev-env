# ICP Developer Environment

This repo contains a Docker image that is used for setting up a remote, hybrid or local development environments for new developers on the IC.

## Usage
This container image can be used as a base for creating a dev container environment that targets ICP development.
Take a look at the repositories below to see dev containers in action:
- [ICP Hello World Motoko](https://github.com/dfinity/icp-hello-world-motoko)
- [ICP Hello World Rust](https://github.com/dfinity/icp-hello-world-rust)

### Packages and Releases 
On the right side, you will find new releases and the latest packages.
You can download the Docker image with 

```bash
docker pull ghcr.io/dfinity/icp-dev-env:latest
```

or 

```bash
docker pull ghcr.io/dfinity/icp-dev-env:<version>
```
for a specific version.

## Creating a new Release
To release a new version, create a new tag with the corresponding version number.
The CI pipeline will automatically build and push the new image to the GitHub Container Registry (ghcr.io).
