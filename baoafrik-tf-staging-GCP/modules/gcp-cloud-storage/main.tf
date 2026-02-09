resource "google_storage_bucket" "staging" {
  name          = var.staging_bucket_name
  location      = var.region
  force_destroy = true

  cors {
    origin = [
      "https://staging.${var.prod_domain}",
      "https://www.staging.${var.prod_domain}",
    ]
    method          = ["GET", "PUT", "POST", "DELETE", "HEAD", "OPTIONS"]
    response_header = ["Content-Type", "Content-MD5", "Content-Disposition", "ETag", "x-goog-request-id"]
    max_age_seconds = 3000
  }
}

resource "google_storage_bucket" "dev" {
  name          = var.dev_bucket_name
  location      = var.region
  force_destroy = true

  cors {
    origin = [
      "http://localhost:3000",
      "http://localhost:3001"
    ]
    method          = ["GET", "PUT", "POST", "DELETE", "HEAD", "OPTIONS"]
    response_header = ["Content-Type", "Content-MD5", "Content-Disposition", "ETag", "x-goog-request-id", "x-goog-content-length-range"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_member" "staging_public_read" {
  bucket = google_storage_bucket.staging.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "dev_public_read" {
  bucket = google_storage_bucket.dev.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "dev_service_account_access" {
  bucket = google_storage_bucket.dev.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_storage_bucket_iam_member" "staging_service_account_access" {
  bucket = google_storage_bucket.staging.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account_email}"
}
