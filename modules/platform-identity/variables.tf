variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "service_accounts" {
  description = "Platform Google service accounts and Workload Identity bindings."
  type = map(object({
    display_name               = string
    description                = string
    kubernetes_namespace       = string
    kubernetes_service_account = string
    project_roles              = list(string)
  }))
}
