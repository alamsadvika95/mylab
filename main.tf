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


resource "google_container_cluster" "primary" {
  provider           = google-beta
  name               = var.cluster_name
  location           = var.location
  # network            = google_compute_network.vpc-network.name
  # subnetwork         = google_compute_subnetwork.subnetwork.name
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
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
