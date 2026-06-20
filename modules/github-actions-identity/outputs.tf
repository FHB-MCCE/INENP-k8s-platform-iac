output "service_account_email" {
  description = "Service account impersonated by the GitHub Actions workflow."
  value       = google_service_account.github_actions.email
}

output "workload_identity_provider" {
  description = "Full provider resource name consumed by google-github-actions/auth."
  value       = google_iam_workload_identity_pool_provider.github.name
}
