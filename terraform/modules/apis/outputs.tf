output "names" {
  value       = values(google_project_service.apis)[*].id
  description = "IDs of all the APIs enabled."
}
