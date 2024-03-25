output "server_url" {
  value       = google_cloud_run_v2_service.default.uri
  description = "URL of the Cloud Run server."
}
output "server_name" {
  value       = google_cloud_run_v2_service.default.name
  description = "Name of the Cloud Run server."
}
