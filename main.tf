provider "google" {
  project     = "cicd-339902"
  region      = "us-central1"
}
provider "google-beta" {
  project     = "cicd-339902"
  region      = "us-central1"
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
#

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
}