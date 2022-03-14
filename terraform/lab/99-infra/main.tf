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

module "cloudsql" {
  source  = "./cloudsql"
  master_instance = "cloudsql"
  region = "us-central1"
  project_id = "terraform-343304"
  preferable_zone = "us-central1-a" 
}