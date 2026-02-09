output "staging_bucket_name" {
  value = google_storage_bucket.staging.name
}

output "dev_bucket_name" {
  value = google_storage_bucket.dev.name
}