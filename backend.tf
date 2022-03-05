terraform {
  backend "gcs" {
    bucket = "cicd-339902-tfstate"
    prefix = "terraform-testing"
  }
}
