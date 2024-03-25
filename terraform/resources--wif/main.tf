# The service account that we are meant to impersonate.
resource "google_service_account" "default" {
  account_id   = "sa-gh-${local.safe_site}"
  display_name = "Service Account for GitHub for the site ${var.site}"
  project      = var.gcp_project_id
}

# All the roles for the given Service Account
resource "google_project_iam_member" "default" {
  project  = var.gcp_project_id
  for_each = toset(local.roles)
  role     = each.key
  member   = "serviceAccount:${google_service_account.default.email}"
}

# Pool for identity specific to the site.
resource "google_iam_workload_identity_pool" "default" {
  project                   = var.gcp_project_id
  workload_identity_pool_id = "gh-pool-${local.safe_site}"
  display_name              = "gh-pool-${local.safe_site}"
  description               = "Identity pool for ${var.site}"
  disabled                  = false
}

# Provider for GitHub.
resource "google_iam_workload_identity_pool_provider" "gh" {
  project                            = var.gcp_project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.default.workload_identity_pool_id
  workload_identity_pool_provider_id = "gh-prov-${local.safe_site}"
  display_name                       = "gh-prov-${local.safe_site}"
  description                        = "Identity provider for ${var.site}"
  disabled                           = false

  # Mapping attributes from the tokens.
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.aud"        = "assertion.aud"
    "attribute.repository" = "assertion.repository"
  }

  # Issuer of the tokens.
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_binding" "provider_gh" {
  service_account_id = google_service_account.default.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.default.name}/attribute.repository/${var.repo}"
  ]
}
