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

module "gke" {
  source = "../../modules/gke"

  project_id                    = var.project_id
  cluster_name                  = "${var.name_prefix}-${var.environment}-gke"
  zone                          = var.zone
  network_self_link             = module.network.network_self_link
  subnet_self_link              = module.network.subnets["gke_nodes"].self_link
  pods_secondary_range_name     = "pods"
  services_secondary_range_name = "services"
  machine_type                  = var.gke_machine_type
  min_node_count                = var.gke_min_node_count
  max_node_count                = var.gke_max_node_count
  labels                        = local.labels
}
