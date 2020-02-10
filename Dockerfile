FROM ubuntu:bionic

LABEL maintainer="Mudit Gupta <hi@mudit.blog>"
LABEL name="rust"
LABEL version="latest"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
    apt upgrade -y && \
    apt curl git npm -y -no-install-recommends && \
    curl https://sh.rustup.rs -sSf | sh && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV PATH=/root/.cargo/bin:$PATH

RUN rustup update nightly && \
    rustup component add rustfmt --toolchain nightly && \
    rustup target add wasm32-unknown-unknown --toolchain nightly && \
    cargo +nightly install --git https://github.com/alexcrichton/wasm-gc --force && \
    cargo --version && \
    cargo +nightly --version && \
    nodejs --version
