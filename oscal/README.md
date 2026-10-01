# OSCAL

This directory contains OSCAL artifacts describing the compliance controls implemented by the Terraform resources in this repository.

## Component

`components/compliant-s3.json` describes the `terraform/primitives/compliant-s3` implementation and maps the following NIST SP 800-53 Rev. 5 controls:

- SC-28 — Protection of Information at Rest
- AC-3 — Access Enforcement
- AU-3 — Content of Audit Records
- CM-6 — Configuration Settings

Each implemented requirement references the Terraform configuration that enforces the control and links to the historical signed evidence bundle produced by Labs 4.3 and 4.4.

The original Lab 4.4 evidence vault was destroyed after the configured retention period expired, so the evidence URI in the component definition documents the intended evidence relationship but is not currently resolvable to a live object.

## Profile

`profiles/cge-p-minimum.json` selects the same four NIST SP 800-53 Rev. 5 controls for the CGE-P minimum control profile.

Both the component definition and profile were validated using `compliance-trestle`.
