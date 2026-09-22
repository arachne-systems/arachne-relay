# Licensing boundary

**Arachne-authored files in this repository: GNU Affero General Public License
v3.0 or later.** See [LICENSE](LICENSE) for the complete license text.

This repository contains a Docker build recipe and documentation, not a
separate Arachne relay implementation. The build copies the upstream Iroh
1.2.0 relay binary from `n0computer/iroh-relay`. The crate manifest and README
declare MIT OR Apache-2.0, but the v1.2.0 relay directory also includes a
BSD-3-Clause notice for Tailscale-derived code. An
[upstream issue](https://github.com/n0-computer/iroh/issues/3863) about how
that notice relates to the crate-wide license is still open. See the
[upstream source](https://github.com/n0-computer/iroh/tree/v1.2.0),
[MIT license](https://github.com/n0-computer/iroh/blob/v1.2.0/LICENSE-MIT), and
[Apache license](https://github.com/n0-computer/iroh/blob/v1.2.0/LICENSE-APACHE),
and the [BSD-3-Clause notice](https://github.com/n0-computer/iroh/blob/v1.2.0/iroh-relay/LICENSE-BSD3).
The binary and its dependencies retain their own terms. This repository does
not publish a prebuilt container image. Hold distribution of a derived image
until the upstream license boundary is clarified and the image has a complete
third-party notice bundle for Iroh, its dependencies, and the Chainguard
runtime.

Core files, Android/ATAK material, credentials, and provider data are outside
this repository's license boundary.
