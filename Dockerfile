FROM ghcr.io/getzola/zola:v0.15.1 AS zola

FROM debian:11-slim as builder
RUN apt-get update -y && \
 apt-get install -y curl && \
 curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.19/mdbook-v0.4.19-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/

FROM debian:11-slim
RUN apt-get update -y && \
  apt-get install -y git
COPY --from=zola /bin/zola /bin/zola
COPY --from=builder /mdbook /bin/mdbook
