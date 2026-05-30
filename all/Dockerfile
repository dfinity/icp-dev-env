FROM rust:1.95.0-slim-bookworm

ARG NODE_VERSION=24.15.0
ARG NVM_VERSION=v0.40.1
ARG PNPM_VERSION=11.4.0
ARG ICP_CLI_VERSION=0.2.7
ARG IC_WASM_VERSION=0.9.11
ARG IC_MOPS_VERSION=2.13.2

ENV NVM_DIR=/root/.nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yqq install --no-install-recommends \
    curl ca-certificates git jq make libdbus-1-3 && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.js via nvm (required for icp-cli, ic-wasm, mops)
RUN curl --fail -sSf https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
    . "${NVM_DIR}/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION}

# pnpm
RUN npm install -g pnpm@${PNPM_VERSION}

# icp-cli + ic-wasm
RUN npm install -g @icp-sdk/icp-cli@${ICP_CLI_VERSION} @icp-sdk/ic-wasm@${IC_WASM_VERSION}

# wasm32 target for Rust canister compilation
RUN rustup target add wasm32-unknown-unknown

# mops (Motoko package manager) — moc is installed per-project via mops install
RUN npm install -g ic-mops@${IC_MOPS_VERSION}
