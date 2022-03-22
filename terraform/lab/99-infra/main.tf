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

# module "cloudsql" {
#   source  = "./cloudsql"
#   project_id = "terraform-343304"
#   master_instance = "cloudsql"
#   region = "us-central1"
#   preferable_zone = "us-central1-a" 
# }

module "cluster" {
  source = "./cluster"
}
