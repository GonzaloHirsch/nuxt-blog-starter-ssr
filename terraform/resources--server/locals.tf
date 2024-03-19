locals {
  safe_site        = replace(var.site, ".", "-")
  safe_subdomain   = split(".", var.site)[0]
  clean_run_domain = replace(google_cloud_run_v2_service.default.uri, "/(https:|/)+/", "")
}
