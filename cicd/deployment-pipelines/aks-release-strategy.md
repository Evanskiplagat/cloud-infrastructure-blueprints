# AKS Release Strategy

This file captures the deployment model behind the GitHub Actions workflows.

## Pipeline Stages

1. Validate Terraform formatting and Kubernetes manifest syntax.
2. Build and test the container artifact.
3. Publish the Docker image to a registry.
4. Authenticate to Azure using OIDC or a federated identity.
5. Fetch AKS credentials and roll out the manifest set.
6. Verify rollout health before marking the deployment complete.

## Production Practices

- Use protected environments for `prod`.
- Require manual approvals for high-risk environments.
- Keep workload configuration external to the container image.
- Use immutable image tags derived from commit SHAs.

