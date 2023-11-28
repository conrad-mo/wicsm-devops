FROM rust:latest as builder
WORKDIR /wicsm-devops
COPY . .
RUN apt-get update && apt-get install libssl-dev pkg-config -y
RUN cargo build --release
RUN chmod +x /wicsm-devops

FROM debian
RUN apt-get update && apt-get install libssl-dev pkg-config ca-certificates -y
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /wicsm-devops/target/release/wicsm-devops /wicsm-devops
ENTRYPOINT ["/wicsm-devops"]
EXPOSE 3000