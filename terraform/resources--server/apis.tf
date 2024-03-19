module "apis" {
  source = "../modules/apis"
  apis = [
    "compute.googleapis.com",
    "run.googleapis.com",
    "iam.googleapis.com"
  ]
}
