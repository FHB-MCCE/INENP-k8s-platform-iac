variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "zone_name" {
  description = "Cloud DNS managed zone resource name."
  type        = string
}

variable "dns_name" {
  description = "DNS suffix managed by the Cloud DNS zone."
  type        = string
}

variable "secrets" {
  description = "Secret Manager secret containers to create. No secret versions are created here."
  type = map(object({
    purpose = string
  }))
}

variable "labels" {
  description = "Labels applied to supported resources."
  type        = map(string)
  default     = {}
}
