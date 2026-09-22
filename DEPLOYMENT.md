# Deployment

The local Compose example uses Iroh's plain-HTTP `--dev` mode. Do not expose
that setup to an untrusted network. For a deployed relay, configure TLS and
use the same hostname in the URL entered by clients.

## Public hostname with Let's Encrypt

The following configuration follows Iroh relay v1.2.0. It disables the
optional metrics and QUIC address-discovery listeners, and uses high container
ports so the service can run as UID 65532.

```toml
http_bind_addr = "[::]:8080"
enable_metrics = false
enable_quic_addr_discovery = false

[tls]
https_bind_addr = "[::]:8443"
hostname = "relay.example.org"
cert_mode = "LetsEncrypt"
cert_dir = "/var/lib/iroh-relay/certs"
contact = "ops@example.org"
```

Save this as `config.toml`, create a `certs` directory writable by UID 65532,
then build and run the image:

```sh
docker build --pull -t arachne-iroh-relay:1.2.0 .
docker run -d --name arachne-iroh-relay \
  --restart unless-stopped \
  --publish 80:8080/tcp --publish 443:8443/tcp \
  --mount "type=bind,src=$PWD/config.toml,dst=/etc/iroh-relay/config.toml,readonly" \
  --mount "type=bind,src=$PWD/certs,dst=/var/lib/iroh-relay/certs" \
  --user 65532:65532 --read-only --cap-drop ALL \
  --security-opt no-new-privileges:true \
  arachne-iroh-relay:1.2.0 -c /etc/iroh-relay/config.toml
```

Point `relay.example.org` at the host and allow the certificate challenge and
client traffic to reach the published ports. Verify the public endpoint with:

```sh
curl --noproxy '*' --fail --show-error https://relay.example.org/healthz
```

The official [Iroh self-hosting guide](https://docs.iroh.computer/iroh-services/relays/self-hosted)
documents the TLS settings and health endpoint. Iroh notes that configuration
details can change; check the [v1.2.0 relay configuration source](https://github.com/n0-computer/iroh/blob/v1.2.0/iroh-relay/src/main.rs)
when changing the pinned binary.

## LAN and closed networks

Clients must resolve the configured hostname to an address they can reach, and
the certificate must be valid for that hostname and trusted by those clients.
A split-DNS record can point the same hostname to a private LAN address while
preserving normal certificate verification.

For a network that cannot complete ACME validation or renew certificates
online, use `cert_mode = "Manual"` with a certificate and key mounted into the
container. The Iroh relay supports `manual_cert_path` and `manual_key_path` in
its TLS configuration. Plan certificate renewal and secure key handling. A
private CA also has to be trusted by every client; test the exact Arachne and
Android client versions before relying on one in production.

The relay forwards Iroh traffic; it is not a peer directory. Configure address
discovery separately if clients need to find endpoints by ID.
