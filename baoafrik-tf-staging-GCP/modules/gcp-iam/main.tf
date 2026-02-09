resource "google_service_account" "app" {
  account_id   = "${var.project}-app-sa"
  display_name = "${var.project} app service account"
}

resource "google_project_iam_member" "app_storage_admin" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.app.email}"
}

resource "google_project_iam_member" "app_storage_object_admin" {
  project = var.project
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.app.email}"
}

resource "google_project_iam_member" "app_storage_viewer" {
  project = var.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.app.email}"
}

resource "google_storage_bucket_iam_member" "public_read" {
  bucket = var.dev_bucket
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}