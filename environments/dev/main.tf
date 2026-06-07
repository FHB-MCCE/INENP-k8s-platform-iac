module "network" {
  source = "../../modules/network"

  project_id   = var.project_id
  region       = var.region
  environment  = var.environment
  network_name = "${var.name_prefix}-${var.environment}-vpc"

  subnets = {
    gke_nodes = {
      name                     = "${var.name_prefix}-${var.environment}-gke-nodes"
      cidr                     = "10.10.0.0/20"
      private_ip_google_access = true
      secondary_ranges = {
        pods     = "10.20.0.0/16"
        services = "10.30.0.0/20"
      }
    }
  }

  labels = local.labels
}
