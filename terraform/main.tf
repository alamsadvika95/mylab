terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

provider "google" {
  project = var.project
}
provider "google-beta" {
  project = var.project
}

module "cluster" {
  source  = "./module/cluster/new-cluster"
}



