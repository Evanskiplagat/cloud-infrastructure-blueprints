# GitHub Actions Examples

The executable workflow files live in `.github/workflows/`, because GitHub Actions only loads workflows from that path.

This directory documents the workflow intent:

- `build.yml`: repository validation including Terraform formatting, Bicep compilation, YAML linting, and a Docker build smoke test
- `test.yml`: deeper verification including Terraform `init` and `validate`, Kubernetes schema validation with `kubeconform`, and demo container endpoint checks
- `docker-image.yml`: build and publish a container image to GitHub Container Registry
- `deploy-aks.yml`: deploy manifests to AKS, create the runtime secret from GitHub Actions secrets, and roll out the commit-specific image tag
