resource "null_resource" "build_container_image" {
  provisioner "local-exec" {
    command = <<EOF
export GITHUB_PAT="${var.github_token}"
export CONTAINER_REGISTRY_NAME="${azurerm_container_registry.main.name}.azurecr.io"
export CONTAINER_IMAGE_NAME="${var.container_name}"

az acr build \
    --registry "$CONTAINER_REGISTRY_NAME" \
    --image "$CONTAINER_IMAGE_NAME" \
    --file "Dockerfile.github" \
    "https://github.com/Azure-Samples/container-apps-ci-cd-runner-tutorial.git"
EOF
  }
}