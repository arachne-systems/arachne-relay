# Keep the upstream relay release and base image immutable for repeatable builds.
ARG IROH_RELAY_IMAGE=n0computer/iroh-relay:v1.2.0@sha256:063ee0e70f2e59d37dfd076e2a1f8bfebf9810ba79b0282fc799512b17d5fe20
FROM ${IROH_RELAY_IMAGE} AS upstream

FROM cgr.dev/chainguard/static:latest@sha256:bf639cba19ba56329e6907ac26a7afcdde57a80b6aa66d5100da6883196e6b82
COPY --from=upstream --chown=65532:65532 /iroh-relay /usr/local/bin/iroh-relay
USER 65532:65532
ENTRYPOINT ["/usr/local/bin/iroh-relay"]
