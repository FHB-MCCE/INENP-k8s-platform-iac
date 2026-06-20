#!/usr/bin/env bash
set -euo pipefail

required_commands=(gcloud kubectl)
for command_name in "${required_commands[@]}"; do
  if ! command -v "${command_name}" >/dev/null 2>&1; then
    echo "Required command is unavailable: ${command_name}" >&2
    exit 1
  fi
done

: "${ARGOCD_VERSION:?ARGOCD_VERSION is required}"
: "${CLUSTER_LOCATION:?CLUSTER_LOCATION is required}"
: "${CLUSTER_NAME:?CLUSTER_NAME is required}"
: "${GITOPS_REPOSITORY:?GITOPS_REPOSITORY is required}"
: "${GITOPS_REVISION:?GITOPS_REVISION is required}"
: "${PROJECT_ID:?PROJECT_ID is required}"

argocd_manifest="https://raw.githubusercontent.com/argoproj/argo-cd/${ARGOCD_VERSION}/manifests/install.yaml"
root_application="https://raw.githubusercontent.com/${GITOPS_REPOSITORY}/${GITOPS_REVISION}/infrastructure/argocd/root-application.yaml"

gcloud container clusters get-credentials "${CLUSTER_NAME}" \
  --location "${CLUSTER_LOCATION}" \
  --project "${PROJECT_ID}" \
  --quiet

kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply --server-side --force-conflicts -n argocd -f "${argocd_manifest}"
kubectl wait --for=condition=Established customresourcedefinition/applications.argoproj.io --timeout=180s
kubectl -n argocd rollout status deployment/argocd-server --timeout=300s
kubectl apply -f "${root_application}"
kubectl -n argocd annotate application/inenp-platform-root argocd.argoproj.io/refresh=hard --overwrite

for attempt in $(seq 1 90); do
  sync_status="$(kubectl -n argocd get application inenp-platform-root -o jsonpath='{.status.sync.status}' 2>/dev/null || true)"
  health_status="$(kubectl -n argocd get application inenp-platform-root -o jsonpath='{.status.health.status}' 2>/dev/null || true)"

  if [[ "${sync_status}" == "Synced" && "${health_status}" == "Healthy" ]]; then
    kubectl -n argocd get applications
    exit 0
  fi

  sleep 10
done

echo "Argo CD root application did not become Synced and Healthy in time." >&2
kubectl -n argocd get applications >&2
exit 1
