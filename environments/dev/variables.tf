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
    argocd-frontend-repo-credentials = {
      purpose = "argocd-frontend-repository"
    }
    database-app-password = {
      purpose = "database-password"
    }
    avwx-api-key = {
      purpose = "backend-weather-api"
    }
    backend-jwt-secret = {
      purpose = "backend-jwt"
    }
    letsencrypt-account-email = {
      purpose = "acme-account"
    }
  }
}

variable "platform_service_accounts" {
  description = "Google service accounts and Workload Identity bindings for platform operators."
  type = map(object({
    display_name               = string
    description                = string
    kubernetes_namespace       = string
    kubernetes_service_account = string
    project_roles              = list(string)
  }))
  default = {
    external-dns = {
      display_name               = "ExternalDNS"
      description                = "Allows ExternalDNS to manage records in Cloud DNS."
      kubernetes_namespace       = "external-dns"
      kubernetes_service_account = "external-dns"
      project_roles = [
        "roles/dns.admin",
      ]
    }
    external-secrets = {
      display_name               = "External Secrets Operator"
      description                = "Allows External Secrets Operator to read Google Secret Manager secrets."
      kubernetes_namespace       = "external-secrets"
      kubernetes_service_account = "external-secrets"
      project_roles = [
        "roles/secretmanager.secretAccessor",
        "roles/secretmanager.viewer",
      ]
    }
    cert-manager = {
      display_name               = "cert-manager DNS01 solver"
      description                = "Allows cert-manager to complete ACME DNS-01 challenges in Cloud DNS."
      kubernetes_namespace       = "cert-manager"
      kubernetes_service_account = "cert-manager"
      project_roles = [
        "roles/dns.admin",
      ]
    }
    crossplane = {
      display_name               = "Crossplane"
      description                = "Allows Crossplane providers to manage Google Cloud resources for tenants."
      kubernetes_namespace       = "crossplane-system"
      kubernetes_service_account = "crossplane"
      project_roles = [
        "roles/iam.serviceAccountUser",
      ]
    }
  }
}
