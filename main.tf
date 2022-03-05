//vpc
resource "google_compute_network" "default" {
  name = "my-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "my-subnet"
  ip_cidr_range = "10.0.0.0/16"
  region        = "us-central1"
  network       = google_compute_network.default.id
}

data "google_compute_image" "debian_image" {
  family  = "debian-9"
  project = "debian-cloud"
}

resource "google_compute_instance" "staging_vm" {
  name         = "staging-vm"
  machine_type = "e2-medium"
  zone         = "us-central1-c"
  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id
    access_config {
    }
  }
}






# resource "google_service_account" "default" {
#   account_id   = "service-account-id"
#   display_name = "Service Account"
# }

# resource "google_container_cluster" "primary" {
#   provider           = google-beta
#   name               = "marcellus-wallace"
#   location           = "us-central1-a"
#   initial_node_count = 1
#   node_config {
#     machine_type = "e2-micro"
#     spot         = true
#     # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#     service_account = google_service_account.default.email
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#     labels = {
#       foo = "bar"
#     }
#     tags = ["foo", "bar"]
#   }
#   timeouts {
#     create = "30m"
#     update = "40m"
#   }
# }