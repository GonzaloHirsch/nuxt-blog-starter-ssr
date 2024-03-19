output "backend_id" {
  value       = aws_s3_bucket.state.id
  description = "ID of the backend bucket."
}

output "backend_region" {
  value       = aws_s3_bucket.state.region
  description = "Region of the backend bucket."
}
