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
