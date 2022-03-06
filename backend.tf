terraform {
  backend "gcs" {
    bucket = "peak-lattice-342202"
    prefix = "terraform"
  }
  # backend "local" {
  #   path = "relative/path/to/terraform.tfstate"
  # }
}
