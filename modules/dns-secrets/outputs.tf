output "dns_zone_name" {
  description = "Name of the Cloud DNS managed zone."
  value       = google_dns_managed_zone.platform.name
}

output "dns_name_servers" {
  description = "Authoritative name servers for manual parent-domain delegation."
  value       = google_dns_managed_zone.platform.name_servers
}

output "secret_ids" {
  description = "Created Secret Manager secret IDs."
  value       = keys(google_secret_manager_secret.platform)
}

output "secret_names" {
  description = "Created Secret Manager resource names keyed by secret ID."
  value = {
    for key, secret in google_secret_manager_secret.platform : key => secret.name
  }
}
