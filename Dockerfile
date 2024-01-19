FROM --platform=linux/amd64 rust:1.75-slim-bookworm

RUN apt -yq update 
RUN apt -yqq install --no-install-recommends curl ca-certificates libunwind-dev git

ENV NVM_DIR=/root/.nvm
ENV NVM_VERSION=v0.39.7
ENV NODE_VERSION=21.5.0

# Install Node.js using nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"
RUN curl --fail -sSf https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash
RUN . "${NVM_DIR}/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm alias default v${NODE_VERSION}

# Install dfx
RUN sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"

# Install wasm32-unknown-unknown target
RUN rustup target add wasm32-unknown-unknown

# Install PocketIC
RUN curl -sLO https://download.dfinity.systems/ic/69e1408347723dbaa7a6cd2faa9b65c42abbe861/openssl-static-binaries/x86_64-linux/pocket-ic.gz
RUN gzip -d pocket-ic.gz
RUN chmod +x pocket-ic
