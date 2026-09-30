# Lab 4.4 — Evidence Chain of Custody

## Chain-of-Custody Properties

| Property     | Evidence                                                                                                                          |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| Authenticity | The Cosign `.sig.bundle` proves the evidence was signed by the GitHub Actions workflow using keyless OIDC identity.               |
| Integrity    | The `.sha256` sidecar records the SHA-256 digest of the evidence bundle. `verify-evidence.sh` recomputes and compares the digest. |
| Timeliness   | The Cosign bundle includes the Fulcio certificate and Rekor transparency-log record associated with the signing event.            |
| Preservation | The evidence bundle is stored in the S3 evidence vault protected by Object Lock retention.                                        |

`verify-evidence.sh` validates these properties and returns `CHAIN INTACT` when verification succeeds.
