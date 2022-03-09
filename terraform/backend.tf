terraform {
  backend "gcs" {
    bucket = "mylab-terraform"
    prefix = "state"
  }
}
