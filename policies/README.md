# Compliance Policies

This directory contains Rego policies used to evaluate infrastructure-as-code against compliance requirements.

## GCP Policies

### SC-28 — Protection of Information at Rest

**File:** `sc28_encryption.rego`  
**Cloud:** GCP  
**Severity:** High

Verifies that Google Cloud Storage buckets are configured with customer-managed encryption keys (CMEK).

**Remediation:** Configure the bucket to use a Cloud KMS key for encryption at rest.

### AC-3 — Access Enforcement

**File:** `ac3_no_public.rego`  
**Cloud:** GCP  
**Severity:** Critical

Verifies that Google Cloud resources do not permit unauthorized public access.

**Remediation:** Remove public access and restrict access to authorized identities and networks.

### CM-6 — Configuration Settings

**File:** `cm6_required_tags.rego`  
**Cloud:** GCP  
**Severity:** Medium

Verifies that required labels are present on Google Cloud resources.

**Remediation:** Add the required labels to the resource configuration.

## AWS Policies

### SC-28 — Protection of Information at Rest

**File:** `sc28_encryption_aws.rego`  
**Cloud:** AWS  
**Severity:** High

Verifies that Amazon S3 buckets have server-side encryption configured.

**Remediation:** Configure server-side encryption for the S3 bucket.

### AC-3 — Access Enforcement

**File:** `ac3_no_public_aws.rego`  
**Cloud:** AWS  
**Severity:** Critical

Verifies that Amazon S3 buckets have public access protections configured.

**Remediation:** Configure S3 public access blocking to prevent unauthorized public access.

### CM-6 — Configuration Settings

**File:** `cm6_required_tags_aws.rego`  
**Cloud:** AWS  
**Severity:** Medium

Verifies that required tags are present on AWS resources.

**Remediation:** Add the required tags to the resource configuration.
