FROM rust:1.97.1-slim-bookworm

ARG NODE_VERSION=24.15.0
ARG NVM_VERSION=v0.40.1
ARG PNPM_VERSION=11.4.0
ARG ICP_CLI_VERSION=1.2.0
ARG IC_WASM_VERSION=0.11.0
ARG CANDID_EXTRACTOR_VERSION=0.1.6
ARG IC_MOPS_VERSION=2.18.0
ARG YQ_VERSION=4.53.3
ARG YQ_SHA256_AMD64=fa52a4e758c63d38299163fbdd1edfb4c4963247918bf9c1c5d31d84789eded4
ARG YQ_SHA256_ARM64=578648e463a11c1b6db6010cbf41eafed6bee79466fcffa1bb446672cf7945ea

ENV NVM_DIR=/root/.nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yqq install --no-install-recommends \
    curl ca-certificates git jq make libdbus-1-3 && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# yq (YAML processor, mikefarah/yq)
RUN ARCH=$(dpkg --print-architecture) && \
    case "${ARCH}" in \
      amd64) YQ_SHA256=${YQ_SHA256_AMD64} ;; \
      arm64) YQ_SHA256=${YQ_SHA256_ARM64} ;; \
      *) echo "unsupported architecture: ${ARCH}" && exit 1 ;; \
    esac && \
    curl --fail -sSL -o /usr/local/bin/yq \
    https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_${ARCH} && \
    echo "${YQ_SHA256}  /usr/local/bin/yq" | sha256sum -c - && \
    chmod +x /usr/local/bin/yq

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

# candid-extractor — uses pre-built binary on amd64, falls back to cargo install on arm64
RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash && \
    cargo binstall --no-confirm candid-extractor@${CANDID_EXTRACTOR_VERSION}

# mops (Motoko package manager) — moc is installed per-project via mops install
RUN npm install -g ic-mops@${IC_MOPS_VERSION}
