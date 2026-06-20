locals {
  apply_roles = toset([
    "roles/compute.networkAdmin",
    "roles/container.admin",
    "roles/dns.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/resourcemanager.projectIamAdmin",
    "roles/secretmanager.admin",
  ])
}

resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = "github-actions-iac"
  display_name = "GitHub Actions Terraform apply"
  description  = "Keyless identity for the protected IaC workflow on the main branch."
}

resource "google_project_iam_member" "apply" {
  for_each = local.apply_roles

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_storage_bucket_iam_member" "terraform_state" {
  bucket = var.state_bucket
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.github_actions.email}"
}

resource "google_iam_workload_identity_pool" "github" {
  project                   = var.project_id
  workload_identity_pool_id = "github-actions"
  display_name              = "GitHub Actions"
  description               = "Federates the INENP IaC workflow without a service account key."
}

resource "google_iam_workload_identity_pool_provider" "github" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "inenp-iac"
  display_name                       = "INENP IaC main"
  description                        = "Accepts only manual workflow runs from the IaC repository main branch."

  attribute_mapping = {
    "google.subject"                = "assertion.sub"
    "attribute.actor"               = "assertion.actor"
    "attribute.ref"                 = "assertion.ref"
    "attribute.repository"          = "assertion.repository"
    "attribute.repository_id"       = "assertion.repository_id"
    "attribute.repository_owner_id" = "assertion.repository_owner_id"
  }

  attribute_condition = join(" && ", [
    "assertion.repository_id == '${var.repository_id}'",
    "assertion.repository_owner_id == '${var.repository_owner_id}'",
    "assertion.repository == '${var.repository}'",
    "assertion.ref == 'refs/heads/main'",
    "assertion.event_name == 'workflow_dispatch'",
  ])

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account_iam_member" "github_federation" {
  service_account_id = google_service_account.github_actions.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository_id/${var.repository_id}"
}
