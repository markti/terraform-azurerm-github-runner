output "container_name" {
  value      = var.container_name
  depends_on = [null_resource.build_container_image]
}