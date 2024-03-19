variable "region" {
  type        = string
  description = "Region of the resources."
}
variable "site" {
  type        = string
  description = "Site that will be meant to target"
  default     = "ssr.gonzalohirsch.com"
}
