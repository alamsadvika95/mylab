data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "terraform-343304"
  name                       = "gke-test-1"
  region                     = "us-central1"
  zones                      = ["us-central1-a", "us-central1-b", "us-central1-f"]
  network                    = module.gcp-network.network_name
  subnetwork                 = module.gcp-network.subnets.subnet_name
  ip_range_pods              = "ip-range-pods"
  ip_range_services          = "ip-range-services"
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  network_policy             = false

  node_pools = [
    {
      name                      = "default-node-pool"
      machine_type              = "e2-micro"
      node_locations            = "us-central1-b,us-central1-c"
      min_count                 = 1
      max_count                 = 100
      local_ssd_count           = 0
      disk_size_gb              = 100
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      auto_repair               = true
      auto_upgrade              = true
      preemptible               = false
      initial_node_count        = 80
    },
  ]

  node_pools_oauth_scopes = {
    all = []

    default-node-pool = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "my-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
}

module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  project_id   = "terraform-343304"
  network_name = "cluster"
  subnets = [
    {
      subnet_name   = "cluster-subnet"
      subnet_ip     = "10.10.0.0/16"
      subnet_region = "us-central1"
    },
  ]
  secondary_ranges = {
    "cluster-subnet" = [
      {
        range_name    = "ip-range-pods"
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = "ip-range-services"
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}