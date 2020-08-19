FROM ubuntu:bionic

LABEL maintainer="Mudit Gupta <hi@mudit.blog>"
LABEL name="rust"
LABEL version="latest"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install cmake pkg-config git gcc build-essential git clang openssh-client \
        libclang-dev curl ca-certificates libssl-dev -y --no-install-recommends && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt install nodejs g++ make yarn -y --no-install-recommends && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/root/.cargo/bin:$PATH

RUN rustup update nightly-2020-07-26 && \
    rustup component add rustfmt --toolchain nightly-2020-07-26 && \
    rustup component add clippy --toolchain nightly-2020-07-26 && \
    rustup target add wasm32-unknown-unknown --toolchain nightly-2020-07-26 && \
    cargo +nightly-2020-07-26 install --git https://github.com/alexcrichton/wasm-gc --force && \
    cargo --version && \
    cargo +nightly-2020-07-26 --version && \
    nodejs --version
