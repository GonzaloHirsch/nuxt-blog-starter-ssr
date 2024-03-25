locals {
  safe_site = replace(var.site, ".", "-")
  roles     = ["roles/artifactregistry.writer", "roles/run.developer"]
}
