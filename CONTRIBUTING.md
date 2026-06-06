# Contributing Guide

## Workflow

### Issues

- Jedes Arbeitspaket wird als GitHub Issue erfasst
- Issues enthalten eine Beschreibung, Aufgabenliste und Akzeptanzkriterien
- Labels (`phase-0`, `phase-1`, etc.) markieren die zeitliche Einordnung

### Branches

Branches folgen dem Schema:

```
feature/<issue-number>-<kurze-beschreibung>
```

Beispiele:
- `feature/3-terraform-network-foundation`
- `feature/8-iac-ci-validation`

### Commits

Wir verwenden [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <beschreibung> (#<issue-number>)
```

**Typen:**
| Typ | Verwendung |
|-----|-----------|
| `feat` | Neue Funktionalität |
| `fix` | Fehlerbehebung |
| `docs` | Dokumentation |
| `ci` | CI/CD-Änderungen |
| `chore` | Wartung, Abhängigkeiten |
| `refactor` | Code-Umstrukturierung |
| `test` | Tests |

**Scopes (dieses Repo):** `iac`, `network`, `gke`, `iam`, `dns`, `secrets`

Beispiele:
- `feat(network): add VPC and subnet configuration (#3)`
- `ci(iac): add Terraform validation workflow (#8)`
- `docs(iac): document bootstrap process (#9)`

### Pull Requests

1. Feature-Branch vom aktuellen `main` erstellen
2. Änderungen committen (Conventional Commits)
3. Pull Request erstellen mit Verweis auf das Issue
4. Mindestens **eine andere Person** reviewt den PR
5. Nach Approval: **Squash Merge** verwenden
6. Branch nach Merge löschen

### Reviews

- Jeder PR benötigt mindestens 1 Approval
- Reviewer prüft: Funktionalität, Code-Qualität, Dokumentation
- Kommentare werden vor Merge aufgelöst

## Verified Pull Requests

Pull Requests gelten als „verified", wenn:
- CI-Checks erfolgreich durchlaufen (grüner Status)
- Mindestens ein Review-Approval vorliegt
- Keine offenen Review-Kommentare existieren

Commit-Signing (GPG/SSH) ist empfohlen, aber nicht erzwungen.

## Branch Protection (Zielzustand)

Für `main` wird angestrebt:
- [x] Require pull request before merging
- [x] Require at least 1 approval
- [x] Require status checks to pass
- [x] Require linear history (Squash Merge)
- [ ] Require signed commits (optional)

## CI-Prüfungen

Dieses Repository validiert PRs automatisch mit:
- `tofu fmt -check` – Formatierung
- `tofu validate` – Konfigurationsvalidierung
- YAML Linting – Workflow-Dateien
