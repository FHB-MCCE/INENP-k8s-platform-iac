resource "google_dns_managed_zone" "platform" {
  project     = var.project_id
  name        = var.zone_name
  dns_name    = "${trim(var.dns_name, ".")}."
  description = "Public Cloud DNS zone for the INENP Kubernetes platform."
  visibility  = "public"

  labels = var.labels
}

resource "google_secret_manager_secret" "platform" {
  for_each = var.secrets

  project   = var.project_id
  secret_id = each.key

  labels = merge(var.labels, {
    purpose = each.value.purpose
  })

  replication {
    auto {}
  }
}
