FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/typescript-node:dev-20-bookworm

ENV DFX_VERSION=0.17.0

# Install a basic environment needed for our build tools
RUN apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates \
    build-essential pkg-config libssl-dev llvm-dev liblmdb-dev clang cmake rsync git

# Install dfx
ENV DFXVM_INIT_YES=true
RUN sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
RUN source "$HOME/.local/share/dfx/env"
