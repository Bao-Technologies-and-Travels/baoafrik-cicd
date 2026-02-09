resource "google_service_account" "app" {
  account_id   = "${var.project}-app-sa"
  display_name = "${var.project} app service account"
}

resource "google_project_iam_member" "app_storage" {
  project = var.project
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.app.email}"
}