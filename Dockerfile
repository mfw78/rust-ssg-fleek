FROM rust:slim AS builder

RUN apt-get update -y && \
  apt-get install -y make g++ libssl-dev curl git && \
  rustup target add x86_64-unknown-linux-gnu

WORKDIR /app
RUN git clone https://github.com/getzola/zola.git .

# Build zola
RUN cargo build --release --target x86_64-unknown-linux-gnu

# Download mdbook
RUN curl -sSL https://github.com/rust-lang/mdBook/releases/download/v0.4.21/mdbook-v0.4.21-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/bin

# Download mdbook-mermaid
RUN curl -sSL https://github.com/badboy/mdbook-mermaid/releases/download/v0.11.1/mdbook-mermaid-v0.11.1-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/bin

# Assemble the final docker image
FROM debian:11-slim
RUN apt-get update -y && \
  apt-get install -y git
COPY --from=builder /app/target/x86_64-unknown-linux-gnu/release/zola /bin/zola
COPY --from=builder /bin/mdbook /bin/mdbook
COPY --from=builder /bin/mdbook-mermaid /bin/mdbook-mermaid