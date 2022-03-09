terraform {
  backend "gcs" {
    bucket = "peak-lattice-342202"
    prefix = "terraform"
  }
}
