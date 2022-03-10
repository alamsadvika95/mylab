resource "google_sql_database_instance" "read_replica" {
  name                 = "replica-${var.master_instance}"
  master_instance_name = "${var.project_id}:${var.master_instance}"
  zone               = "${var.zone}"
  region             = "${var.region}"
  database_version     = "MYSQL_5_7"

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = "100"
    backup_configuration {
      enabled = false
    }
    ip_configuration {
      ipv4_enabled    = true
      private_network = "projects/${var.project_id}/global/networks/default"
    }
    location_preference {
      zone = "us-central1-a"
    }
  }
}