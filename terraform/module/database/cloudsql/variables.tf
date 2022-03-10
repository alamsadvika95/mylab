variable "project_id" {
  description = "The project ID to host the cluster in"
  default     = "cicd-339902" 
}
variable "master_instance" {
  description = "The name for the GKE cluster"
  default     = "mysqlinstance"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "asia-southeast2"
}