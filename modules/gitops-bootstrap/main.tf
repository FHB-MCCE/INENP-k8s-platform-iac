resource "terraform_data" "argocd" {
  triggers_replace = [
    var.cluster_endpoint,
    var.argocd_version,
    var.gitops_revision,
  ]

  provisioner "local-exec" {
    command     = "${path.module}/scripts/bootstrap-argocd.sh"
    interpreter = ["/usr/bin/env", "bash"]

    environment = {
      ARGOCD_VERSION    = var.argocd_version
      CLUSTER_LOCATION  = var.cluster_location
      CLUSTER_NAME      = var.cluster_name
      GITOPS_REPOSITORY = var.gitops_repository
      GITOPS_REVISION   = var.gitops_revision
      PROJECT_ID        = var.project_id
    }
  }
}
