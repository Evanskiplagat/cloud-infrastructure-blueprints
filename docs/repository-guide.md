# Repository Guide

This document explains how the repository is organized and how the example assets fit together in a realistic cloud delivery workflow.

## Design Principles

- Keep infrastructure definitions modular and readable.
- Separate provisioning concerns from workload deployment concerns.
- Document assumptions directly next to the implementation.
- Prefer secure-by-default examples such as private networking boundaries, managed identities, and secret references.

## Suggested Demo Flow

1. Provision shared platform resources from `terraform/landing-zone`.
2. Build network foundations from `terraform/networking`.
3. Deploy the AKS platform from `terraform/aks-cluster`.
4. Apply workload manifests from `kubernetes/`.
5. Enable monitoring from `monitoring/`.
6. Connect the delivery flows in `.github/workflows/`.

## Environment Conventions

- Resource names use a short environment suffix like `dev`, `test`, or `prod`.
- Global tagging is applied through Terraform variables to keep governance consistent.
- AKS deployment examples assume an Azure Container Registry integration pattern.

## Security Considerations

- Store runtime secrets in Azure Key Vault or an external secrets operator rather than Git.
- Use OIDC-based GitHub Actions federation instead of long-lived Azure service principal secrets where possible.
- Restrict AKS ingress exposure with TLS, WAF, and IP filtering in production.
- The AKS deployment workflow creates `platform-web-secrets` from GitHub Actions secrets `PLATFORM_WEB_API_KEY` and `PLATFORM_WEB_DATABASE_URL`; keep `kubernetes/secrets/app-secret.example.yaml` as a local-only reference.
