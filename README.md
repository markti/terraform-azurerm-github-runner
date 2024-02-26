# terraform-azurerm-github-runner
Provision a Custom Runner for GitHub Actions

## Host Environment

This Terraform module provisions a container app environment optimized for hosting a GitHub Custom Runner as a container app job. The environment includes a Key Vault for storing the GitHub token, an Azure Container Registry (ACR) for the container image, a Log Analytics workspace for Azure Monitor logging, and a virtual network for secure communication.

![Resource](./docs/images/host-env.jpg)

This module will run Docker in a `null_resource` to create the GitHub Runner container image that is needed for the GitHub Custom Runner. Make sure you Docker Desktop is running when you execute this locally.

![Resource](./docs/images/acr-image.jpg)

If the Docker image is built and pushed successfully you will see it in the Azure Container Registry under the `github-runner` repository.