terraform {
  backend "gcs" {
    bucket = "terraform-343304-tfstate"
    prefix = "terraform"
  }
  # backend "local" {
  #   path = "relative/path/to/terraform.tfstate"
  # }
}
