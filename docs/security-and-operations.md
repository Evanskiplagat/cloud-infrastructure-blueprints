# Security and Operations

This repository intentionally includes operational guidance so the examples look like a real engineering handoff rather than isolated code samples.

## Security Baseline

- Enforce least-privilege access for Terraform and CI/CD identities.
- Prefer managed identities for AKS-integrated Azure resources.
- Restrict storage account public access unless a workload explicitly requires it.
- Rotate secrets and certificates through automated processes where possible.

## Operational Baseline

- Tag all resources with environment, owner, cost-center, and business-service metadata.
- Use health probes and autoscaling for containerized workloads.
- Export metrics and define alerts for availability, saturation, and deployment failures.
- Keep runbooks alongside dashboards and alerts for faster incident response.

