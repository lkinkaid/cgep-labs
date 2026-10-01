# Lab 5.4 — GCP Security Services Baseline

## Overview

This lab was intended to demonstrate three GCP security patterns:

- Organization Policy as a preventive control
- Workload Identity Federation (WIF) for keyless GitHub Actions authentication
- Data Access audit logging

The WIF and audit logging portions were successfully configured during the lab. The Organization Policy portion could not be completed because the available GCP environments did not provide the required organization-level permissions.

## What Was Successfully Implemented

The following components were created and validated during the lab:

- Workload Identity Pool for GitHub Actions
- GitHub OIDC provider
- Repository-scoped Workload Identity Federation condition
- `cgep-grc-gate-sa` service account
- `roles/viewer` assignment for the service account
- `roles/iam.workloadIdentityUser` binding for the trusted GitHub repository
- Data Access audit logging configuration for:
  - `storage.googleapis.com`
  - `cloudkms.googleapis.com`
  - `iam.googleapis.com`
- GitHub Actions WIF demo workflow using OIDC instead of a service-account JSON key

The Terraform-managed resources created during testing were later destroyed.

## Organization Policy Blocker

The lab also requires creation of these project-scoped Organization Policy constraints:

- `storage.uniformBucketLevelAccess`
- `iam.disableServiceAccountKeyCreation`
- `compute.requireOsLogin`

Terraform attempted to create these resources using `google_org_policy_policy`, but the GCP API returned:

```text
Permission 'orgpolicy.policies.create' denied
```
