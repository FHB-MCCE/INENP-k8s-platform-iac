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

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

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
- Secret Manager Container für GHCR Pull Token, Datenbankpasswort, Backend JWT Secret und ACME Kontakt

Der GCS-State-Bucket wird in Gate 1 nur konfiguriert. Er wird vor dem ersten `terraform init` in Gate 2 separat angelegt.

Die Cloud DNS Delegation bleibt ein manueller Schritt: Nach dem ersten Apply müssen die ausgegebenen Name Server im Parent-Domain-Setup von `naehrer.me` eingetragen werden. Secret-Werte werden nicht durch Terraform verwaltet; Gate 1 legt nur die Secret-Container an.

## CI/CD

Pull Requests werden automatisch validiert:

- `terraform fmt -check`
- `terraform validate`
- YAML Linting

## Lizenz

Internes Hochschulprojekt - FH Burgenland INENP 2026.
