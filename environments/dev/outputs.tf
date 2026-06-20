output "network_name" {
  description = "Name of the VPC network."
  value       = module.network.network_name
}

output "network_self_link" {
  description = "Self link of the VPC network."
  value       = module.network.network_self_link
}

output "gke_subnet_name" {
  description = "Name of the subnet used by GKE nodes."
  value       = module.network.subnets["gke_nodes"].name
}

output "gke_subnet_secondary_ranges" {
  description = "Secondary ranges for GKE pods and services."
  value       = module.network.subnets["gke_nodes"].secondary_ranges
}

output "gke_cluster_name" {
  description = "Name of the GKE cluster."
  value       = module.gke.cluster_name
}

output "gke_cluster_location" {
  description = "Location of the GKE cluster."
  value       = module.gke.cluster_location
}

output "gke_node_pool_name" {
  description = "Name of the primary GKE node pool."
  value       = module.gke.node_pool_name
}

output "gke_node_service_account_email" {
  description = "Email address of the GKE node service account."
  value       = module.gke.node_service_account_email
}

output "dns_zone_name" {
  description = "Name of the Cloud DNS managed zone."
  value       = module.dns_secrets.dns_zone_name
}

output "dns_name_servers" {
  description = "Authoritative name servers for manual parent-domain delegation."
  value       = module.dns_secrets.dns_name_servers
}

output "secret_manager_secret_ids" {
  description = "Secret Manager secret containers created for the platform."
  value       = module.dns_secrets.secret_ids
}

output "platform_service_account_emails" {
  description = "Google service account emails for platform operators."
  value       = module.platform_identity.service_account_emails
}

output "workload_identity_annotations" {
  description = "Kubernetes service account annotations for platform operators."
  value       = module.platform_identity.workload_identity_annotations
}

output "github_actions_service_account" {
  description = "Service account used by the keyless Terraform apply workflow."
  value       = module.github_actions_identity.service_account_email
}

output "github_actions_workload_identity_provider" {
  description = "Workload Identity provider trusted by the Terraform apply workflow."
  value       = module.github_actions_identity.workload_identity_provider
}

output "gitops_bootstrap_id" {
  description = "Identifier of the automated Argo CD and root Application bootstrap."
  value       = module.gitops_bootstrap.bootstrap_id
}
