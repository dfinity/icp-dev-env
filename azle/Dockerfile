FROM --platform=linux/amd64 node:slim

RUN apt -yq update
RUN apt -yqq install --no-install-recommends curl ca-certificates libunwind-dev git python3

# Install dfx
RUN DFX_VERSION=0.24.2 DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
ENV PATH="/root/.local/share/dfx/bin:$PATH"

# Install azle extension
RUN npx azle@0.24.1 install-dfx-extension

# Clean apt
RUN apt-get autoremove && apt-get clean
