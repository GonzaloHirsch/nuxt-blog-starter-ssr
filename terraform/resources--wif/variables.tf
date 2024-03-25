variable "gcp_project_id" {
  type        = string
  description = "ID for the GCP project compute resources."
}
variable "site" {
  type        = string
  description = "Site that will be meant to target"
  default     = "ssr.gonzalohirsch.com"
}
variable "repo" {
  type        = string
  description = "Owner/Repository for the actions."
  default     = "GonzaloHirsch/nuxt-blog-starter-ssr"
}
