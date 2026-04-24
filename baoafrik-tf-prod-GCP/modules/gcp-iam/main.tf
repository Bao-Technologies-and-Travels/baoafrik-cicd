resource "google_service_account" "app" {
  account_id   = "${var.project_id}-app-sa"
  display_name = "${var.project_id} app service account"
}

resource "google_project_iam_member" "app_storage" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.app.email}"
}
