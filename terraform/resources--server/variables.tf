variable "gcp_region" {
  type        = string
  description = "Region to use for GCP. By default is `us-east1`."
  default     = "us-east1"
}
variable "region" {
  type        = string
  description = "Region to use for AWS. By default is `us-east-1`."
  default     = "us-east-1"
}
variable "gcp_project_id" {
  type        = string
  description = "ID for the GCP project compute resources."
}
variable "site" {
  type        = string
  description = "Site that will be meant to target."
  default     = "ssr.gonzalohirsch.com"
}
variable "image" {
  type        = string
  description = "URI for Docker image."
}
variable "min_instances" {
  type        = number
  description = "Min number of instances for server."
  default     = 0
}
variable "max_instances" {
  type        = number
  description = "Max number of instances for server."
  default     = 1
}
variable "port" {
  type        = number
  description = "Port that the image listens to."
  default     = 3000
}
variable "max_request_concurrency" {
  type        = number
  description = "Number of concurrent requests each container can handle."
  default     = 500
}
variable "budget_limit" {
  type        = number
  description = "Limit for the GCP budget."
  default     = 1
}
variable "aws_hosted_zone_id" {
  type        = string
  description = "ID for the AWS hosted zone."
}
variable "main_billing_account_name" {
  type        = string
  description = "Name of the main billing account."
  default     = "My Billing Account"
}
