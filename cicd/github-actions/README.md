# GitHub Actions Examples

The executable workflow files live in `.github/workflows/`, because GitHub Actions only loads workflows from that path.

This directory documents the workflow intent:

- `build.yml`: lint and static validation
- `test.yml`: Kubernetes manifest and Terraform formatting checks
- `docker-image.yml`: build and publish a container image to GitHub Container Registry
- `deploy-aks.yml`: deploy manifests to AKS after image publication

