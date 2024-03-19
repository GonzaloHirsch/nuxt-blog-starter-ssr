resource "aws_s3_bucket" "state" {
  bucket = "${replace(var.site, ".", "-")}--terraform-backend"
  tags = {
    app = var.site
  }
}
