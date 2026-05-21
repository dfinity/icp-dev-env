FROM rust:1.89-slim-bookworm

ARG NODE_VERSION=22.10.0
ARG NVM_VERSION=v0.40.1
ARG ICP_CLI_VERSION=latest
ARG IC_WASM_VERSION=latest

ENV NVM_DIR=/root/.nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

RUN apt-get -yq update && apt-get -yqq install --no-install-recommends \
    curl ca-certificates git libunwind-dev && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.js via nvm (required for icp-cli and ic-wasm)
RUN curl --fail -sSf https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
    . "${NVM_DIR}/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION}

# pnpm
RUN npm install -g pnpm

# icp-cli + ic-wasm
RUN npm install -g @icp-sdk/icp-cli@${ICP_CLI_VERSION} @icp-sdk/ic-wasm@${IC_WASM_VERSION}

# wasm32 target for canister compilation
RUN rustup target add wasm32-unknown-unknown
