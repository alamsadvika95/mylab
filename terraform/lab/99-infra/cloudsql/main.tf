resource "google_sql_database_instance" "cloudsql_instance" {
  name                 = "${var.master_instance}"
  region               = "${var.region}"
  database_version     = "MYSQL_5_7"
  deletion_protection  = false

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = "10"
    disk_type         = "PD_HDD"
    backup_configuration {
      enabled = false
    }
    ip_configuration {
      ipv4_enabled    = true
      private_network = "projects/terraform-343304/global/networks/default"
    }
  }
}

resource "google_sql_database_instance" "read_replica" {
  name                 = "replicas-${var.master_instance}"
  master_instance_name = google_sql_database_instance.cloudsql_instance.name
  region               = "${var.region}"
  database_version     = "MYSQL_5_7"
  deletion_protection  = false
  depends_on = [
    google_sql_database_instance.cloudsql_instance
  ]

  replica_configuration {
    failover_target = false
  }

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"
    disk_size         = "10"
    disk_type         = "PD_HDD"
    backup_configuration {
      enabled = false
      binary_log_enabled = true
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

