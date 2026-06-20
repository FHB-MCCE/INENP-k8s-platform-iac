variable "project_id" {
  description = "Google Cloud project ID used by the Terraform apply workflow."
  type        = string
}

variable "repository" {
  description = "GitHub repository allowed to federate with Google Cloud."
  type        = string
}

variable "repository_id" {
  description = "Immutable numeric GitHub repository ID used in the OIDC condition."
  type        = string
}

variable "repository_owner_id" {
  description = "Immutable numeric GitHub organization ID used in the OIDC condition."
  type        = string
}

variable "state_bucket" {
  description = "GCS bucket containing the Terraform state."
  type        = string
}
