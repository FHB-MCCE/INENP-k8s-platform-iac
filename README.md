# INENP Kubernetes Platform - Infrastructure as Code

Terraform-Konfiguration für die GCP-Infrastruktur der INENP Kubernetes Platform.

## Überblick

Dieses Repository enthält die Infrastructure-as-Code-Definitionen für:

- **VPC & Netzwerk** - Custom VPC, Subnets, Firewall Rules
- **GKE Cluster** - Google Kubernetes Engine (Standard, zonal)
- **IAM & Workload Identity** - Service Accounts, Bindings
- **Cloud DNS** - Managed DNS Zone
- **Secret Manager** - Google Secret Manager Ressourcen

## Voraussetzungen

- [Terraform](https://www.terraform.io/) >= 1.5
- GCP-Projekt mit aktivierten APIs
- Authentifizierung (`gcloud auth application-default login`)

## Quickstart

Der bevorzugte Gate-6-Pfad ist der Workflow **Apply Infrastructure** unter
GitHub Actions. Ein berechtigtes Teammitglied startet ihn auf `main` über
`workflow_dispatch` und bestätigt mit `APPLY`. Danach laufen Terraform, der
Argo-CD-Bootstrap und die Root Application ohne weitere Klicks oder manuelle
`kubectl apply`-Schritte.

Der folgende lokale Ablauf bleibt für Entwicklung und Recovery verfügbar:

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## One-Click Deployment

Der Apply-Workflow authentifiziert sich ohne statischen Schlüssel über GitHub
OIDC und einen dedizierten Google Service Account. Der Trust ist auf die
unveränderliche Repository-ID, die Organisations-ID, den Branch `main` und
manuelle `workflow_dispatch`-Runs begrenzt.

Terraform führt nach dem GKE-Apply automatisch einen idempotenten Bootstrap
aus:

1. GKE-Zugang für den Workflow Runner konfigurieren
2. Argo CD in der gepinnten Version `v3.4.3` installieren oder aktualisieren
3. die Root Application aus dem GitOps-Repository anwenden
4. auf `Synced / Healthy` warten und die Applications protokollieren

Einmalige Ausnahme: Der OIDC-Pool und der Actions Service Account müssen vor
dem ersten Workflow-Run durch einen bereits berechtigten Projektadministrator
erzeugt werden. Dieser Vertrauensanker wird selbst durch Terraform verwaltet:

```bash
cd environments/dev
terraform init
terraform apply -target=module.github_actions_identity
```

Danach benötigt der Workflow weder einen GCP-Schlüssel noch ein GitHub Secret.
Manuell bleiben nur externe Glue Points, die nicht automatisch erzeugt werden
können: die Parent-DNS-Delegation und das Eintragen kundenseitig bereitgestellter
Werte in Google Secret Manager.

## Projektstruktur

```text
.
├── modules/          # Wiederverwendbare Terraform-Module
├── environments/     # Umgebungsspezifische Konfigurationen
├── .github/          # CI/CD Workflows
└── README.md
```

## Umgebung `dev`

Die Umgebung `environments/dev` bildet die Projektvorgaben ab:

- GCP-Projekt `dulcet-velocity-495612-j0`
- Region `europe-west3`
- Zone `europe-west3-a`
- Custom VPC `inenp-dev-vpc`
- Subnet `inenp-dev-gke-nodes` mit separaten Secondary Ranges für Pods und Services
- Zonal GKE Standard Cluster `inenp-dev-gke`
- Node Pool mit `n2-standard-2`, Autoscaling von 3 bis 4 Nodes
- Workload Identity mit `dulcet-velocity-495612-j0.svc.id.goog`
- Cloud DNS Zone `inenp-naehrer-me` für `inenp.naehrer.me`
- Secret Manager Container für GHCR Pull Token, Argo CD Frontend-Repo-Zugriff, Datenbankpasswort, AVWX API Key, Backend JWT Secret und ACME Kontakt
- Google Service Accounts und Workload Identity Bindings für ExternalDNS, ESO, cert-manager und Crossplane

Der GCS-State-Bucket wird in Gate 1 nur konfiguriert. Er wird vor dem ersten `terraform init` in Gate 2 separat angelegt.

Die Cloud DNS Delegation bleibt ein manueller Schritt: Nach dem ersten Apply müssen die ausgegebenen Name Server im Parent-Domain-Setup von `naehrer.me` eingetragen werden. Secret-Werte werden nicht durch Terraform verwaltet; Gate 1 legt nur die Secret-Container an. Der GHCR Pull Token wird von Kubernetes für Image Pulls verwendet; das separate Argo CD Frontend-Repo-Secret wird von Argo CD benötigt, um das private Frontend-Repository als Helm-Quelle lesen zu können.

Der administrative Cluster-Zugang für den Lehrenden ist in
[docs/lecturer-cluster-access.md](docs/lecturer-cluster-access.md) dokumentiert.
Er verwendet die bereits berechtigte institutionelle Google-Identität und
keine geteilten Zugangsdaten.

## CI/CD

Pull Requests werden automatisch validiert:

- `terraform fmt -check`
- `terraform validate`
- YAML Linting

Der geschützte Apply-Workflow ist ausschließlich manuell auf `main` startbar,
verwendet eine serialisierte Concurrency Group und veröffentlicht keine
Credentials oder Secret-Werte.

## Lizenz

Internes Hochschulprojekt - FH Burgenland INENP 2026.
