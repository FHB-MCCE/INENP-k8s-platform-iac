resource "google_service_account" "platform" {
  for_each = var.service_accounts

  project      = var.project_id
  account_id   = each.key
  display_name = each.value.display_name
  description  = each.value.description
}

resource "google_project_iam_member" "project_roles" {
  for_each = {
    for binding in flatten([
      for account_key, account in var.service_accounts : [
        for role in account.project_roles : {
          key         = "${account_key}-${replace(replace(role, "/", "-"), ".", "-")}"
          account_key = account_key
          role        = role
        }
      ]
    ]) : binding.key => binding
  }

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.platform[each.value.account_key].email}"
}

resource "google_service_account_iam_member" "workload_identity" {
  for_each = {
    for account_key, account in var.service_accounts : account_key => account
  }

  service_account_id = google_service_account.platform[each.key].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${each.value.kubernetes_namespace}/${each.value.kubernetes_service_account}]"
}
