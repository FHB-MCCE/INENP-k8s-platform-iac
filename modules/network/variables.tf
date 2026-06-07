variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Google Cloud region for regional network resources."
  type        = string
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network."
  type        = string
}

variable "subnets" {
  description = "Subnets to create in the VPC."
  type = map(object({
    name                     = string
    cidr                     = string
    private_ip_google_access = bool
    secondary_ranges         = map(string)
  }))
}

variable "labels" {
  description = "Labels applied to resources that support labels."
  type        = map(string)
  default     = {}
}
