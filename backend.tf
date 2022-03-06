terraform {
  backend "gcs" {
    bucket = "terraform-343304-tfstate"
    prefix = "terraform"
  }
}
