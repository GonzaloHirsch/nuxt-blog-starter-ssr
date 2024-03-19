data "google_compute_default_service_account" "default" {
  project    = var.gcp_project_id
  depends_on = [module.apis]
}

resource "google_cloud_run_v2_service" "default" {
  # Location
  location = var.gcp_region
  project  = var.gcp_project_id

  # Description
  name        = "${local.safe_site}--service"
  description = "Cloud Run instance to serve the SSR site ${var.site}"

  # Traffic
  ingress = "INGRESS_TRAFFIC_ALL"
  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  template {
    # Scaling limits to ensure we control this.
    max_instance_request_concurrency = var.max_request_concurrency
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    # Run this as the default compute.
    service_account = data.google_compute_default_service_account.default.email

    containers {
      image = var.image

      # Where the container listens for requests.
      ports {
        container_port = var.port
      }

      # How to find out if it is healthy.
      startup_probe {
        initial_delay_seconds = 30
        timeout_seconds       = 1
        period_seconds        = 3
        failure_threshold     = 1
        tcp_socket {
          port = var.port
        }
      }

      # Limits for the container to follow.
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
        # Allow it to become idle and then removed.
        cpu_idle = true
      }
    }
  }
  depends_on = [module.apis]
}


# Policy for no authentication.
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

# Policy to allow unauthenticated requests.
resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.default.location
  project  = google_cloud_run_v2_service.default.project
  service  = google_cloud_run_v2_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
