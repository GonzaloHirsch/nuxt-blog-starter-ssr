output "sa_email" {
  value       = google_service_account.default.email
  description = "Email of the service account we are meant to use later."
}

output "wif_pool_name" {
  value       = google_iam_workload_identity_pool.default.name
  description = "Name of the Identity Pool."
}

output "wif_pool_provider_name" {
  value       = google_iam_workload_identity_pool_provider.gh.name
  description = "Name of the Identity Pool Provider."
}
