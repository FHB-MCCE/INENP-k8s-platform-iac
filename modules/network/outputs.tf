output "network_name" {
  description = "Name of the VPC network."
  value       = google_compute_network.this.name
}

output "network_id" {
  description = "ID of the VPC network."
  value       = google_compute_network.this.id
}

output "network_self_link" {
  description = "Self link of the VPC network."
  value       = google_compute_network.this.self_link
}

output "subnets" {
  description = "Subnet metadata keyed by input subnet key."
  value = {
    for key, subnet in google_compute_subnetwork.this : key => {
      name             = subnet.name
      id               = subnet.id
      self_link        = subnet.self_link
      ip_cidr_range    = subnet.ip_cidr_range
      secondary_ranges = subnet.secondary_ip_range
    }
  }
}
