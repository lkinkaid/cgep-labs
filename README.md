# CGE-P Labs - GRC Engineering Portfolio

Hands-on governance, risk, and compliance engineering labs completed as part of the Certified Governance Expert - Practitioner (CGE-P) program.

This repository demonstrates how traditional compliance requirements can be translated into infrastructure-as-code, policy-as-code, automated evidence collection, cryptographic chain-of-custody controls, cloud-native security monitoring, and OSCAL-based machine-readable compliance documentation.

## What This Portfolio Demonstrates

The labs in this repository build toward an end-to-end compliance engineering workflow:

```text
Security Framework / Control
          ↓
Infrastructure as Code
          ↓
Policy as Code
          ↓
CI/CD Enforcement
          ↓
Evidence Collection
          ↓
Cryptographic Signing
          ↓
Immutable Evidence Storage
          ↓
OSCAL Control Mapping
```

Rather than relying exclusively on screenshots, manual control narratives, and point-in-time audit procedures, the goal is to demonstrate how compliance evidence can be generated and validated directly from engineering workflows.

## Technologies Used

- Terraform
- AWS
- Google Cloud Platform
- Open Policy Agent (OPA)
- Rego
- Conftest
- tfsec
- GitHub Actions
- GitHub OIDC
- AWS Security Hub
- AWS CloudTrail
- AWS Config
- Google Cloud Workload Identity Federation
- Cosign / Sigstore
- Amazon S3 Object Lock
- OSCAL
- compliance-trestle
- Bash
- JSON

## Completed Labs

### Lab 2.3 - First Compliant Resource

Built a compliant-by-default AWS S3 Terraform primitive implementing controls including:

- SC-28 - Protection of Information at Rest
- AC-3 - Access Enforcement
- AU-3 / AU-6 - Audit Logging
- CM-6 - Configuration Settings

The implementation includes server-side encryption, versioning, public-access blocking, access logging, and required compliance tags.

Evidence:

- `evidence/lab-2-3/plan.json`
- `evidence/lab-2-3/state.json`

Implementation:

- `terraform/primitives/compliant-s3/`

---

### Lab 2.4 - Terraform Modules for Compliance

Built a reusable Google Cloud Storage module that applies a consistent compliance baseline across consumers.

Controls include:

- SC-12 - Cryptographic Key Establishment and Management
- SC-13 - Cryptographic Protection
- SC-28 - Protection of Information at Rest
- AU-11 - Audit Record Retention
- CM-6 - Configuration Settings
- AC-3 - Access Enforcement

Evidence:

- `evidence/lab-2-4/plan.json`
- `evidence/lab-2-4/attestation.json`

Implementation:

- `terraform/modules/compliant-gcs-bucket/`

---

### Lab 2.5 - Infrastructure as Compliance Evidence

Created an evidence-capture workflow backed by an S3 Object Lock evidence vault.

The workflow captures infrastructure artifacts, calculates hashes, creates a manifest, uploads the evidence bundle, and records the immutable object version.

Evidence:

- `evidence/lab-2-5/receipt.json`

Implementation:

- `terraform/primitives/evidence-vault/`
- `scripts/capture-evidence.sh`

---

### Lab 3.3 - Compliance Policies with Rego

Implemented policy-as-code checks using Open Policy Agent and Rego.

Policies evaluate infrastructure for:

- SC-28 - Encryption
- AC-3 - Public Access
- CM-6 - Required Configuration Labels

The policies include test fixtures covering compliant and non-compliant conditions.

Evidence:

- `evidence/lab-3-3/opa-test-results.json`

Implementation:

- `policies/`
- `policies/tests/`

---

### Lab 3.4 - Policy-as-Code Terraform Gate

Extended the policy library with AWS-specific policies and integrated Conftest into a reusable Terraform policy gate.

The gate evaluates Terraform plan output and fails when required controls are not satisfied.

Evidence:

- `evidence/lab-3-4/conftest-pass.json`
- `evidence/lab-3-4/conftest-fail.json`

Implementation:

- `scripts/policy-gate.sh`
- `policies/*_aws.rego`

---

### Lab 4.3 - Automated GRC Evidence Pipeline

Built a GitHub Actions pipeline that:

1. Authenticates to AWS using GitHub OIDC
2. Runs Terraform validation and planning
3. Evaluates Terraform plans with Conftest
4. Scans infrastructure with tfsec
5. Captures machine-readable evidence
6. Enforces policy results before allowing the workflow to succeed

The repository history includes both successful and intentionally failing pipeline executions to demonstrate enforcement behavior.

Implementation:

- `.github/workflows/grc-gate.yml`
- `terraform/primitives/oidc-trust/`

---

### Lab 4.4 - Evidence Chain of Custody

Extended the GRC pipeline with cryptographic evidence signing using Cosign.

Each pipeline run generates:

- an evidence bundle
- SHA-256 integrity hash
- Cosign signature bundle
- S3 Object Lock versioned evidence
- a receipt identifying the run and stored artifact

A verification script validates:

- authenticity
- integrity
- timeliness
- preservation

Evidence:

- `evidence/lab-4-4/receipt.json`
- `WRITEUP.md`

Implementation:

- `scripts/verify-evidence.sh`
- `.github/workflows/grc-gate.yml`

---

### Lab 5.2 - AWS Security Services Baseline

Built an AWS-native monitoring baseline using:

- AWS CloudTrail
- AWS Security Hub
- AWS Config

Control mappings include:

| Service      | NIST SP 800-53 Controls |
| ------------ | ----------------------- |
| CloudTrail   | AU-2, AU-12, AU-10      |
| Security Hub | RA-5, SI-4              |
| AWS Config   | CM-2, CM-6, CM-8        |

Security Hub findings were exported as machine-readable evidence.

Evidence:

- `evidence/lab-5-2/security-hub-findings.json`

Implementation:

- `terraform/baselines/aws/`

---

### Lab 5.4 - GCP Security Services Baseline

Implemented portions of a Google Cloud security baseline including:

- Workload Identity Federation for GitHub Actions
- GitHub OIDC authentication
- repository-scoped workload identity
- service-account keyless authentication
- Data Access audit logging

The Organization Policy portion of the lab could not be completed because the available GCP environments did not grant the required `orgpolicy.policies.create` permission.

This limitation is intentionally documented rather than bypassed or represented as completed.

Implementation:

- `terraform/baselines/gcp/`
- `.github/workflows/gcp-wif-demo.yml`

See:

- `terraform/baselines/gcp/README.md`

---

### Lab 6.1 - OSCAL

Created machine-readable OSCAL artifacts describing the relationship between NIST SP 800-53 controls and the Terraform implementation.

The OSCAL component definition maps:

| Control | Terraform Enforcement                                        |
| ------- | ------------------------------------------------------------ |
| SC-28   | `aws_s3_bucket_server_side_encryption_configuration.primary` |
| AC-3    | `aws_s3_bucket_public_access_block.primary`                  |
| AU-3    | `aws_s3_bucket_logging.primary`                              |
| CM-6    | `provider.aws.default_tags`                                  |

The OSCAL profile selects the same four controls from the NIST SP 800-53 Rev. 5 catalog.

Both artifacts were validated using `compliance-trestle`.

Artifacts:

- `oscal/components/compliant-s3.json`
- `oscal/profiles/cge-p-minimum.json`

Validation evidence:

- `evidence/lab-6-1/trestle-validate.txt`

The OSCAL component references the historical signed evidence bundle generated during Lab 4.4. That lab environment was later destroyed after the configured evidence-retention period expired, so the historical S3 URI is no longer live.

## End-to-End Evidence Chain

The repository demonstrates a complete compliance engineering chain:

```text
NIST SP 800-53
      ↓
OSCAL Profile
      ↓
OSCAL Component Definition
      ↓
Terraform Implementation
      ↓
OPA / Rego Policy
      ↓
Conftest Gate
      ↓
GitHub Actions
      ↓
Terraform Plan + Security Evidence
      ↓
SHA-256 + Cosign Signature
      ↓
S3 Object Lock Evidence Vault
```

This creates a traceable path from a compliance requirement to the engineering implementation and ultimately to the evidence generated by the system.

## Repository Structure

```text
.github/workflows/
    CI/CD and identity federation workflows

evidence/
    Machine-readable evidence captured during labs

oscal/
    OSCAL component definitions and profiles

policies/
    Rego compliance policies and tests

scripts/
    Evidence capture, policy gate, and verification tooling

terraform/
    Terraform primitives, modules, and cloud security baselines
```

## Key Takeaways

These labs reinforced several GRC engineering principles:

- Controls can be implemented as reusable engineering patterns rather than manual instructions.
- Policy-as-code enables preventive compliance checks before infrastructure changes are deployed.
- CI/CD pipelines can continuously generate audit-ready evidence.
- OIDC and workload identity federation reduce reliance on long-lived cloud credentials.
- Cryptographic signatures and immutable storage improve evidence authenticity and integrity.
- Cloud-native security services can provide continuous compliance evidence.
- OSCAL provides a standardized way to connect control requirements, technical implementations, and evidence.

## About This Repository

This repository is a hands-on learning portfolio focused on expanding traditional GRC and cybersecurity consulting skills into GRC engineering, compliance automation, infrastructure-as-code, and policy-as-code.

The goal is not simply to reproduce lab instructions, but to understand how compliance requirements can be represented, enforced, tested, and evidenced through engineering workflows.
