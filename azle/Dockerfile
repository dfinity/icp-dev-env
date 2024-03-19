FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/typescript-node:dev-20-bookworm 

# Install a basic environment needed for our build tools
RUN apt-get -yq update
RUN apt-get -yqq install --no-install-recommends curl ca-certificates \
    build-essential pkg-config libssl-dev llvm-dev liblmdb-dev clang cmake rsync git

# Install dfx
RUN DFX_VERSION=0.18.0 DFXVM_INIT_YES=true sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
ENV PATH="/root/.local/share/dfx/bin:$PATH"

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain=1.73.0 --profile=minimal
ENV PATH="/root/.cargo/bin:$PATH"
RUN rustup target add wasm32-wasi

RUN cargo install --git https://github.com/wasm-forge/wasi2ic --rev 806c3558aad24224852a9582f018178402cb3679

RUN git clone https://github.com/demergent-labs/wasmedge-quickjs && cd wasmedge-quickjs && git checkout 6c81d7e6fe4b22a468beceed0ee697f4163e7ca8
RUN mkdir -p ${HOME}/.config/azle
RUN mv /wasmedge-quickjs ${HOME}/.config/azle/wasmedge_quickjs_$(npx azle@0.21.0-rc.0 dockerfile-hash)

# Clean apt
RUN apt-get autoremove && apt-get clean
