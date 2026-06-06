# INENP Kubernetes Platform – Infrastructure as Code

Terraform/OpenTofu-Konfiguration für die GCP-Infrastruktur der INENP Kubernetes Platform.

## Überblick

Dieses Repository enthält die Infrastructure-as-Code-Definitionen für:

- **VPC & Netzwerk** – Custom VPC, Subnets, Firewall Rules
- **GKE Cluster** – Google Kubernetes Engine (Standard, zonal)
- **IAM & Workload Identity** – Service Accounts, Bindings
- **Cloud DNS** – Managed DNS Zone
- **Secret Manager** – Google Secret Manager Ressourcen

## Voraussetzungen

- [OpenTofu](https://opentofu.org/) >= 1.5 oder [Terraform](https://www.terraform.io/) >= 1.5
- GCP-Projekt mit aktivierten APIs
- Authentifizierung (`gcloud auth application-default login`)

## Quickstart

```bash
cd environments/dev
tofu init
tofu plan
tofu apply
```

## Projektstruktur

```
.
├── modules/          # Wiederverwendbare Terraform-Module
├── environments/     # Umgebungsspezifische Konfigurationen
├── .github/          # CI/CD Workflows
└── README.md
```

## CI/CD

Pull Requests werden automatisch validiert:
- `tofu fmt -check`
- `tofu validate`
- YAML Linting

## Lizenz

Internes Hochschulprojekt – FH Burgenland INENP 2026.
