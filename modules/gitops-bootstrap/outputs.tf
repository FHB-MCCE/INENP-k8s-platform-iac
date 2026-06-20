output "bootstrap_id" {
  description = "Terraform identifier of the automated GitOps bootstrap."
  value       = terraform_data.argocd.id
}
