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
