data "google_billing_account" "account" {
  provider     = google
  display_name = var.main_billing_account_name
}

# Cannot create a subaccount since we are not a reseller.
# resource "google_billing_subaccount" "account" {
#   display_name           = "Billing Account - ${upper(local.safe_subdomain)}"
#   master_billing_account = data.google_billing_account.account.id
# }

# Billing limits for the GCP project
resource "google_billing_budget" "budget" {
  billing_account = data.google_billing_account.account.id
  display_name    = "Billing Budget - ${upper(local.safe_subdomain)}"
  amount {
    specified_amount {
      currency_code = "USD"
      units         = var.budget_limit
    }
  }
  threshold_rules {
    threshold_percent = 0.5
  }
  depends_on = [module.apis]
}
