## Control Mapping

| AWS Service  | NIST 800-53 Controls | Implementation                                                                                         |
| ------------ | -------------------- | ------------------------------------------------------------------------------------------------------ |
| CloudTrail   | AU-2, AU-12, AU-10   | Multi-region management-event logging with log-file validation enabled.                                |
| Security Hub | RA-5, SI-4           | Centralized security monitoring using NIST 800-53 Rev. 5 and AWS Foundational Security Best Practices. |
| AWS Config   | CM-2, CM-6, CM-8     | Continuous resource configuration recording using a customer-managed configuration recorder.           |

## Implementation Note

AWS Config was deployed as part of this lab to support continuous resource
configuration recording and Security Hub control evaluation.

During the initial deployment, Security Hub standards were enabled before an
AWS Config configuration recorder was available. The standards consequently
reported an `INCOMPLETE` status with the following reason:

`NO_AVAILABLE_CONFIGURATION_RECORDER`

A customer-managed AWS Config recorder (`cgep-lab-config`) was then deployed
and verified as actively recording with a `SUCCESS` status.

Because the Security Hub standards had initialized before AWS Config was
available, the Terraform-managed AWS Foundational Security Best Practices
(FSBP) and NIST SP 800-53 Rev. 5 subscriptions were recreated after the
configuration recorder was healthy.

Following reinitialization, the Terraform-managed AWS Foundational Security
Best Practices (FSBP) and NIST SP 800-53 Rev. 5 standards transitioned from
`PENDING` to `READY` without the `NO_AVAILABLE_CONFIGURATION_RECORDER` status
reason. Security Hub then began evaluating controls and generating findings.

### Lesson Learned

Continuous control monitoring depends on the availability of its upstream
evidence sources. Deploying a monitoring service alone does not guarantee that
its controls can operate. In this implementation, Security Hub depended on
AWS Config resource recording for control evaluation, making provisioning
order an important part of the control implementation.

After initialization completed, Security Hub began evaluating controls and
producing machine-readable findings. Findings were exported to:

`evidence/lab-5-2/security-hub-findings.json`

## Evidence

Security Hub findings were exported as machine-readable JSON to:

`evidence/lab-5-2/security-hub-findings.json`

The evidence contains Security Hub control findings, including severity,
control status, affected resources, and remediation information generated
from the deployed AWS environment.
