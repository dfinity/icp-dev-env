FROM --platform=linux/amd64 rust:1.83-slim-bookworm

ENV NVM_DIR=/root/.nvm
ENV NVM_VERSION=v0.40.1
ENV NODE_VERSION=22.10.0
ENV POCKET_IC_SERVER_VERSION=7.0.0
ENV POCKET_IC_PYTHON_VERSION=3.0.0

RUN apt -yq update
RUN apt -yqq install --no-install-recommends curl ca-certificates libunwind-dev git python3 python3-pip ssh

# Install Node.js using nvm
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"
RUN curl --fail -sSf https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash
RUN . "${NVM_DIR}/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "${NVM_DIR}/nvm.sh" && nvm alias default v${NODE_VERSION}

# Install dfx
RUN DFX_VERSION=0.24.3 DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
ENV PATH="/root/.local/share/dfx/bin:$PATH"

# Add wasm32-unknown-unknown target
RUN rustup target add wasm32-unknown-unknown

# Install PocketIC Python
RUN pip3 install pocket-ic==${POCKET_IC_PYTHON_VERSION} --break-system-packages

# Download the PocketIC server
RUN curl -Ls https://github.com/dfinity/pocketic/releases/download/${POCKET_IC_SERVER_VERSION}/pocket-ic-x86_64-linux.gz -o pocket-ic.gz
RUN gzip -d pocket-ic.gz
RUN chmod +x pocket-ic
RUN mv pocket-ic /usr/local/bin

# Clean apt
RUN apt-get autoremove && apt-get clean
