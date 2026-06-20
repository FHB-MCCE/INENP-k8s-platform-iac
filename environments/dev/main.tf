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

module "dns_secrets" {
  source = "../../modules/dns-secrets"

  project_id = var.project_id
  zone_name  = var.dns_zone_name
  dns_name   = var.domain_name
  secrets    = var.secret_manager_secrets
  labels     = local.labels
}

module "platform_identity" {
  source = "../../modules/platform-identity"

  project_id       = var.project_id
  service_accounts = var.platform_service_accounts
}

module "github_actions_identity" {
  source = "../../modules/github-actions-identity"

  project_id          = var.project_id
  repository          = "FHB-MCCE/INENP-k8s-platform-iac"
  repository_id       = "1233723146"
  repository_owner_id = "283122619"
  state_bucket        = "dulcet-velocity-495612-j0-inenp-tfstate"
}

module "gitops_bootstrap" {
  source = "../../modules/gitops-bootstrap"

  project_id        = var.project_id
  cluster_name      = module.gke.cluster_name
  cluster_location  = module.gke.cluster_location
  cluster_endpoint  = nonsensitive(module.gke.cluster_endpoint)
  argocd_version    = "v3.4.3"
  gitops_repository = "FHB-MCCE/INENP-k8s-platform-gitops"
  gitops_revision   = "main"

  depends_on = [module.gke]
}
