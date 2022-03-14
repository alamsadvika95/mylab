resource "google_sql_database_instance" "read_replica" {
  name                 = "${var.master_instance}"
  region               = "${var.region}"
  database_version     = "MYSQL_5_7"
  deletion_protection  = false

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
      zone = "${var.preferable_zone}"
    }
  }
}
