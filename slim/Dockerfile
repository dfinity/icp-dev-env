FROM --platform=linux/amd64 rust:1.89-slim-bookworm

ENV NVM_DIR=/root/.nvm
ENV NVM_VERSION=v0.40.1
ENV NODE_VERSION=22.10.0
ENV IC_MOPS_VERSION=1.11.1

RUN apt -yq update
RUN apt -yqq install --no-install-recommends curl ca-certificates libunwind-dev git

# Install Node.js using nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"
RUN curl --fail -sSf https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash
RUN . "${NVM_DIR}/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm alias default v${NODE_VERSION}

# Install ic-mops
RUN npm install -g ic-mops@${IC_MOPS_VERSION}

# Install dfx
RUN DFX_VERSION=0.29.0 DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
ENV PATH="/root/.local/share/dfx/bin:$PATH"

# Add wasm32-unknown-unknown target
RUN rustup target add wasm32-unknown-unknown

# Install candid-extractor
RUN curl -fsSL https://github.com/dfinity/candid-extractor/releases/download/0.1.6/candid-extractor-x86_64-unknown-linux-gnu.tar.gz -o candid-extractor.tar.gz
RUN tar -xvf candid-extractor.tar.gz && rm candid-extractor.tar.gz
RUN mv candid-extractor /usr/local/bin

# Clean apt
RUN apt-get autoremove && apt-get clean
