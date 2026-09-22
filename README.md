# Arachne Relay

A self-hosting recipe for the upstream Iroh relay used by Arachne and other
Iroh clients. This repository does not implement or fork the relay protocol;
it packages the upstream `iroh-relay` binary in a small Chainguard runtime.

**Status: preview.** The pinned relay passed a host-local, two-endpoint Rust
onboarding qualification. Android-device, WAN, and production-certificate
behavior still need separate verification. Arachne client integration belongs
in the client repositories; this deployment recipe does not add the client
setting by itself.

## Try it locally

Start the HTTP development relay:

```sh
docker compose up --build
```

It listens on the host at `127.0.0.1:3340` for same-host testing. Check it with:

```sh
curl --noproxy '*' --fail --show-error http://127.0.0.1:3340/healthz
```

For a trusted LAN test, bind the port on the host's interfaces:

```sh
RELAY_BIND_ADDRESS=192.168.1.50 docker compose up --build
```

Replace `192.168.1.50` with the host's LAN address. From another device, use
`http://192.168.1.50:3340`. This is plain HTTP development mode; keep it on a
trusted network. Stop the relay with `docker compose down`.

## Deploy with HTTPS

Use a stable hostname and a trusted TLS certificate for normal deployments.
The upstream relay can obtain Let's Encrypt certificates with ACME. See
[deployment instructions](DEPLOYMENT.md) for public-host, LAN, and closed
network setups.

On Arachne client versions with the **Custom Iroh relay** setting, configure
the same reachable relay URL on each endpoint. See the public
[Arachne for ATAK project](https://github.com/arachne-systems/arachne-atak) for
client and release information. Relay selection is separate from Iroh address
discovery; clients still need a way to learn endpoint addresses.

## Version and licensing

The Dockerfile pins Iroh relay v1.2.0 and a Chainguard static runtime by image
digest. Review [LICENSING.md](LICENSING.md) before redistributing a built
container image. Arachne-authored repository files are under
[AGPL-3.0-or-later](LICENSE). See [SECURITY.md](SECURITY.md) to report a
vulnerability.
