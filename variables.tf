variable "project_id" {
 description = "The project ID to host the cluster in"
 default   ="terraform-343304-tfstate"
}
variable "cluster_name" {
 description = "The name for the GKE cluster"
 default     = "spotvm-cluster"
}
variable "location" {
 description = "The region to host the cluster in"
 default     = "asia-southeast2"
}
variable "machine_type" {
 description = "The region to host the cluster in"
 default     = "e2-micro"
}
variable "network" {
 description = "The VPC network created to host the cluster in"
 default     = "cluster"
}
variable "subnetwork" {
 description = "The subnetwork created to host the cluster in"
 default     = "spotvm"
}

