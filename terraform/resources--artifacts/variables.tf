variable "gcp_region" {
  type        = string
  description = "Region to use for GCP. By default is `europe-west1`."
  default     = "europe-west1"
}
variable "gcp_project_id" {
  type        = string
  description = "ID for the GCP project compute resources."
}
variable "site" {
  type        = string
  description = "Site that will be meant to target"
  default     = "ssr.gonzalohirsch.com"
}
