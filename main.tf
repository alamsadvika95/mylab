terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.12.0"
    }
  }
}

provider "google" {
  project     = var.project_id
}
provider "google-beta" {
  project     = var.project_id
}

module "gke_auth" {
 source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
 project_id   = var.project_id
 location     = var.location
 cluster_name = google_container_cluster.primary.name
}


resource "google_container_cluster" "primary" {
  provider           = google-beta
  name               = var.cluster_name
  location           = var.location
  network            = google_compute_network.vpc-network.name
  subnetwork         = google_compute_subnetwork.subnetwork.name
  initial_node_count = 1

  node_config {
    machine_type = var.machine_type
    spot         = true
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      foo = "bar"
    }
    tags = ["foo", "bar"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork
  ip_cidr_range = "10.2.0.0/16"
  region        = var.location
  network       = google_compute_network.vpc-network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}

resource "google_compute_network" "vpc-network" {
  name                    = var.network
  auto_create_subnetworks = false
  mtu                     = 1460
}


