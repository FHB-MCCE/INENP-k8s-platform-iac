terraform {
  backend "gcs" {
    bucket = "dulcet-velocity-495612-j0-inenp-tfstate"
    prefix = "terraform/state/dev"
  }
}
