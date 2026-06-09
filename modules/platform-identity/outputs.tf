output "service_account_emails" {
  description = "Google service account email addresses keyed by account ID."
  value = {
    for key, account in google_service_account.platform : key => account.email
  }
}

output "workload_identity_annotations" {
  description = "Kubernetes service account annotations keyed by account ID."
  value = {
    for key, account in var.service_accounts : key => {
      namespace = account.kubernetes_namespace
      name      = account.kubernetes_service_account
      annotation = {
        "iam.gke.io/gcp-service-account" = google_service_account.platform[key].email
      }
    }
  }
}
