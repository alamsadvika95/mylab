terraform {
  backend "local" {
    # credentials = "./terraform-gke-keyfile.json"
    path = "relative/path/to/terraform.tfstate"
  }
}
