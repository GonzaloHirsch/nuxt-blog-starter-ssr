output "registry_id" {
  value       = google_artifact_registry_repository.default.id
  description = "ID of the artifact registry."
}

output "registry_location" {
  value       = google_artifact_registry_repository.default.location
  description = "Location of the artifact registry."
}

output "registry_name" {
  value       = google_artifact_registry_repository.default.name
  description = "Name of the artifact registry."
}

output "gcp_project_id" {
  value       = var.gcp_project_id
  description = "ID of the GCP project."
}
