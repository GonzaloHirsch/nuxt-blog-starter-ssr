module "apis" {
  source = "../modules/apis"
  apis = [
    "billingbudgets.googleapis.com",
    "artifactregistry.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com"
  ]
}

# This is where we'll store the Docker images.
resource "google_artifact_registry_repository" "default" {
  location      = var.gcp_region
  project       = var.gcp_project_id
  repository_id = "${replace(var.site, ".", "-")}--repository"
  description   = "Artifact repository for ${var.site}."
  format        = "DOCKER"

  # This will ensure that we keep only a couple of images.
  cleanup_policies {
    id     = "keep-minimum-versions"
    action = "KEEP"
    most_recent_versions {
      keep_count = 3
    }
  }
  depends_on = [module.apis]
}
