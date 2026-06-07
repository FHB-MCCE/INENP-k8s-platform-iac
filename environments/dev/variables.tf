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
