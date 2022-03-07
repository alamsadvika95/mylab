variable "project_id" {
 description = "The project ID to host the cluster in"
 default   ="terraform-343304"
}
variable "cluster_name" {
 description = "The name for the GKE cluster"
 default     = "testing"
}
variable "location" {
 description = "The region to host the cluster in"
 default     = "asia-southeast2"
}
variable "machine_type" {
 description = "The region to host the cluster in"
 default     = "e2-micro"
}


