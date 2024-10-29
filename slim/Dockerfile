FROM --platform=linux/amd64 rust:1.75-slim-bookworm

ENV NVM_DIR=/root/.nvm
ENV NVM_VERSION=v0.40.1
ENV NODE_VERSION=22.10.0
ENV DFX_VERSION=0.24.1

RUN apt -yq update
RUN apt -yqq install --no-install-recommends curl ca-certificates libunwind-dev git

# Install Node.js using nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"
RUN curl --fail -sSf https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash
RUN . "${NVM_DIR}/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm alias default v${NODE_VERSION}

# Install dfx
RUN DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
ENV PATH="/root/.local/share/dfx/bin:$PATH"
ENV DFX_VERSION=

# Add wasm32-unknown-unknown target
RUN rustup target add wasm32-unknown-unknown

# Install candid-extractor
RUN cargo install candid-extractor

# Clean apt
RUN apt-get autoremove && apt-get clean
