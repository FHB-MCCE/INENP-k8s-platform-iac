output "cluster_name" {
  description = "Name of the GKE cluster."
  value       = google_container_cluster.this.name
}

output "cluster_location" {
  description = "Location of the GKE cluster."
  value       = google_container_cluster.this.location
}

output "cluster_endpoint" {
  description = "Endpoint of the GKE cluster."
  value       = google_container_cluster.this.endpoint
  sensitive   = true
}

output "node_service_account_email" {
  description = "Email address of the GKE node service account."
  value       = google_service_account.nodes.email
}

output "node_pool_name" {
  description = "Name of the primary GKE node pool."
  value       = google_container_node_pool.primary.name
}
