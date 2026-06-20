variable "project_id" {
  description = "Google Cloud project containing the GKE cluster."
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster that receives the GitOps bootstrap."
  type        = string
}

variable "cluster_location" {
  description = "Zone or region of the GKE cluster."
  type        = string
}

variable "cluster_endpoint" {
  description = "GKE API endpoint used to rerun the bootstrap after cluster replacement."
  type        = string
}

variable "argocd_version" {
  description = "Pinned Argo CD release used by the bootstrap manifest."
  type        = string
}

variable "gitops_repository" {
  description = "GitHub owner and repository containing the Argo CD root Application."
  type        = string
}

variable "gitops_revision" {
  description = "Git revision used to retrieve the root Application manifest."
  type        = string
}
