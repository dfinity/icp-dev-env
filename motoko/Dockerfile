FROM ubuntu:24.04

ARG NODE_VERSION=22.10.0
ARG NVM_VERSION=v0.40.1
ARG MOC_VERSION=1.8.1
ARG ICP_CLI_VERSION=0.2.7
ARG IC_WASM_VERSION=0.9.11
ARG IC_MOPS_VERSION=2.13.2

ENV NVM_DIR=/root/.nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"
ENV MOPS_CACHE=/root/.cache/mops

RUN apt-get -yq update && apt-get -yq upgrade && apt-get -yqq install --no-install-recommends \
    curl ca-certificates git && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Node.js via nvm (required for icp-cli, ic-wasm, mops)
RUN curl --fail -sSf https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
    . "${NVM_DIR}/nvm.sh" && \
    nvm install ${NODE_VERSION} && \
    nvm alias default ${NODE_VERSION}

# pnpm
RUN npm install -g pnpm

# icp-cli + ic-wasm
RUN npm install -g @icp-sdk/icp-cli@${ICP_CLI_VERSION} @icp-sdk/ic-wasm@${IC_WASM_VERSION}

# mops (Motoko package manager)
RUN npm install -g ic-mops@${IC_MOPS_VERSION}

# moc (Motoko compiler) via mops toolchain — installs to /root/.cache/mops/moc/{version}/moc
RUN mops toolchain use moc ${MOC_VERSION} && \
    ln -sf /root/.cache/mops/moc/${MOC_VERSION}/moc /usr/local/bin/moc
