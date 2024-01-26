# ICP Developer Environment

This repo contains a Docker image that is used for setting up a remote, hybrid or local development environments for new developers on the IC.

## Packages and Releases 
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

To release a new version, create a new tag with the corresponding version number.
The CI pipeline will automatically build and push the new image to the GitHub Container Registry (ghcr.io).

## Usage
The recommended way of using this image is to use one of the following template repositories:
- [ICP Hello World Motoko](https://github.com/dfinity/icp-hello-world-motoko)
- [ICP Hello World Rust](https://github.com/dfinity/icp-hello-world-rust)
