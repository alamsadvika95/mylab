variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "terraform-343304" 
}
variable "master_instance" {
  description = "The name for the GKE cluster"
  default     = "sqlinstance"
}
variable "zone" {
  description = "The region to host the cluster in"
  default     = "asia-southeast2-b"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "asia-southeast2"
}
