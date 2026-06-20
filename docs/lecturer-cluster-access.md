# Lecturer Cluster Access

The assignment requires the lecturer to have administrative access to the GKE
cluster. Access uses the lecturer's own institutional Google identity; no
shared kubeconfig, service account key, password, or long-lived credential is
created.

## Current Authorization

The institutional lecturer identity is already a project-level `roles/owner`
member in `dulcet-velocity-495612-j0`. This role includes the permissions to
connect to GKE and manage Kubernetes API objects. A second permanent
`cluster-admin` binding would duplicate this access and is therefore not
created.

The relevant GKE permissions included in basic and predefined roles are listed
in the [Google Cloud IAM role reference](https://cloud.google.com/iam/docs/roles-permissions/container).

The cluster retains the standard GKE `system:masters` ClusterRoleBinding. No
team-owned credential is used to impersonate the lecturer.

## Verification

The lecturer can verify access with their own institutional account:

```bash
gcloud auth login
gcloud config set project dulcet-velocity-495612-j0
gcloud container clusters get-credentials inenp-dev-gke \
  --zone europe-west3-a \
  --project dulcet-velocity-495612-j0
kubectl auth can-i '*' '*' --all-namespaces
```

The final command must return `yes`. The check confirms Kubernetes API access
without exposing credentials to the team or GitHub.

## Recovery

If the institutional identity changes or the verification returns `no`, a
project administrator must update the IAM membership for the confirmed new
identity. The change must be documented in the related GitHub issue before a
replacement role or Kubernetes binding is introduced.
