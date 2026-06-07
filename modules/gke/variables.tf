variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster."
  type        = string
}

variable "zone" {
  description = "Google Cloud zone for the zonal GKE cluster."
  type        = string
}

variable "network_self_link" {
  description = "Self link of the VPC network."
  type        = string
}

variable "subnet_self_link" {
  description = "Self link of the subnet used by GKE nodes."
  type        = string
}

variable "pods_secondary_range_name" {
  description = "Name of the subnet secondary range used for Pods."
  type        = string
}

variable "services_secondary_range_name" {
  description = "Name of the subnet secondary range used for Services."
  type        = string
}

variable "machine_type" {
  description = "Machine type used by the primary node pool."
  type        = string
  default     = "n2-standard-2"
}

variable "min_node_count" {
  description = "Minimum node count for the primary node pool."
  type        = number
  default     = 3
}

variable "max_node_count" {
  description = "Maximum node count for the primary node pool."
  type        = number
  default     = 4
}

variable "disk_size_gb" {
  description = "Boot disk size for GKE nodes."
  type        = number
  default     = 80
}

variable "release_channel" {
  description = "GKE release channel."
  type        = string
  default     = "REGULAR"
}

variable "labels" {
  description = "Labels applied to supported GKE resources."
  type        = map(string)
  default     = {}
}
