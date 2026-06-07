variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
  default     = "dulcet-velocity-495612-j0"
}

variable "region" {
  description = "Primary Google Cloud region."
  type        = string
  default     = "europe-west3"
}

variable "zone" {
  description = "Primary Google Cloud zone."
  type        = string
  default     = "europe-west3-a"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "name_prefix" {
  description = "Prefix used for project resources."
  type        = string
  default     = "inenp"
}

variable "gke_machine_type" {
  description = "Machine type used by the GKE node pool."
  type        = string
  default     = "n2-standard-2"
}

variable "gke_min_node_count" {
  description = "Minimum node count for the GKE node pool."
  type        = number
  default     = 3
}

variable "gke_max_node_count" {
  description = "Maximum node count for the GKE node pool."
  type        = number
  default     = 4
}

variable "domain_name" {
  description = "DNS domain delegated to the platform."
  type        = string
  default     = "inenp.naehrer.me"
}

variable "dns_zone_name" {
  description = "Cloud DNS managed zone name."
  type        = string
  default     = "inenp-naehrer-me"
}

variable "secret_manager_secrets" {
  description = "Secret Manager secret containers created without secret versions."
  type = map(object({
    purpose = string
  }))
  default = {
    frontend-ghcr-pull-token = {
      purpose = "ghcr-pull-token"
    }
    database-app-password = {
      purpose = "database-password"
    }
    backend-jwt-secret = {
      purpose = "backend-jwt"
    }
    letsencrypt-account-email = {
      purpose = "acme-account"
    }
  }
}
