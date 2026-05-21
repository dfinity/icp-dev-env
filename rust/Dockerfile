FROM ubuntu:24.04

ARG NODE_VERSION=22.10.0
ARG NVM_VERSION=v0.40.1
ARG RUST_VERSION=1.89.0
ARG ICP_CLI_VERSION=0.2.7
ARG IC_WASM_VERSION=0.9.11

ENV NVM_DIR=/root/.nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:/root/.cargo/bin:${PATH}"

RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yqq install --no-install-recommends \
    curl ca-certificates git && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Rust via rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    sh -s -- -y --default-toolchain ${RUST_VERSION} --target wasm32-unknown-unknown

# Node.js via nvm (required for icp-cli and ic-wasm)
RUN curl --fail -sSf https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
    . "${NVM_DIR}/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION}

# pnpm
RUN npm install -g pnpm

# icp-cli + ic-wasm
RUN npm install -g @icp-sdk/icp-cli@${ICP_CLI_VERSION} @icp-sdk/ic-wasm@${IC_WASM_VERSION}
