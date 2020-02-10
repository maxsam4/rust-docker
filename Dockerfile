FROM ubuntu:bionic

LABEL maintainer="Mudit Gupta <hi@mudit.blog>"
LABEL name="rust"
LABEL version="latest"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt install cmake pkg-config git gcc build-essential git clang \
        libclang-dev curl ca-certificates -y --no-install-recommends && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt install nodejs g++ make yarn -y --no-install-recommends && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/root/.cargo/bin:$PATH

RUN rustup update nightly && \
    rustup component add rustfmt --toolchain nightly && \
    rustup target add wasm32-unknown-unknown --toolchain nightly && \
    cargo +nightly install --git https://github.com/alexcrichton/wasm-gc --force && \
    cargo --version && \
    cargo +nightly --version && \
    nodejs --version
