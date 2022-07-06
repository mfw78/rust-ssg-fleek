FROM rust:slim AS builder

RUN apt-get update -y && \
  apt-get install -y make g++ libssl-dev curl && \
  rustup target add x86_64-unknown-linux-gnu

WORKDIR /app
COPY . .

RUN cargo build --release --target x86_64-unknown-linux-gnu
RUN curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.19/mdbook-v0.4.19-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/bin

FROM debian:11-slim
RUN apt-get update -y && \
  apt-get install -y git
COPY --from=builder /bin/zola /bin/zola
COPY --from=builder /bin/mdbook /bin/mdbook
