resource "google_storage_bucket" "prod" {
  name          = var.prod_bucket_name
  location      = var.region
  force_destroy = true

  cors {
    origin = [
      "https://${var.prod_domain}",
      "https://www.${var.prod_domain}",
    ]
    method          = ["GET", "PUT", "POST", "DELETE", "HEAD", "OPTIONS"]
    response_header = ["Content-Type", "Content-MD5", "Content-Disposition", "ETag", "x-goog-request-id"]
    max_age_seconds = 3000
  }
}

resource "google_storage_bucket_iam_member" "prod_public_read" {
  bucket = google_storage_bucket.prod.name
  role   = "roles/storage.objectAdmin"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "prod_service_account_access" {
  bucket = google_storage_bucket.prod.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}
