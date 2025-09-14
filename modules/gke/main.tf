resource "google_container_cluster" "primary" {
    name = var.cluster_name
    location = var.region
    # location = "us-central1-a"
    project = var.project_id


    remove_default_node_pool = true
    initial_node_count = 1


    networking_mode = "VPC_NATIVE"


    ip_allocation_policy {
        cluster_secondary_range_name = "pods-range"
        services_secondary_range_name = "services-range"
    }


    network = var.vpc_link
    subnetwork = var.subnet_link


    private_cluster_config {
        enable_private_nodes = true
        enable_private_endpoint = true
        # master_ipv4_cidr_block = var.master_ipv4_cidr
    }

    master_authorized_networks_config {
    }

    workload_identity_config {
        workload_pool = "${var.project_id}.svc.id.goog"
    }


    network_policy {
        enabled = true
        provider = "CALICO"
    }


    # enable_shielded_nodes {
    #     enabled = true
    # }


    release_channel {
        channel = "REGULAR"
    }


#     logging_config {
#         component_config {
#         enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
#     }
# }


    # monitoring_config {
    #     managed_prometheus_config {
    #         enabled = false
    # }
    # }

    deletion_protection = false
    # depends_on = [null_resource.wait_for_apis]
}


resource "google_container_node_pool" "primary_nodes" {
    name = "primary-pool"
    # location = "us-central1-a"

    location = var.region
    project = var.project_id
    cluster = google_container_cluster.primary.name


    node_config {
        service_account = var.service_acc
        machine_type = var.node_machine_type
        disk_size_gb = 20

        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform",
        ]


        metadata = {
            disable-legacy-endpoints = "true"
    }


        shielded_instance_config {
            enable_secure_boot = true
            enable_integrity_monitoring = true
        }
    }


    initial_node_count = var.node_count
    autoscaling {
        min_node_count = 1
        max_node_count = 2
    }


    management {
        auto_upgrade = true
        auto_repair = true
    }


    depends_on = [google_container_cluster.primary]
}


#Bastion Host ----------------------------------------------------
resource "google_compute_instance" "bastion" {
  name         = "bastion-host-${var.environment}"
  project = var.project_id
  machine_type = "e2-micro" # free tier eligible
  zone         = var.zone #"us-central1-a" # pick same region/zone as GKE

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11" # lightweight
      size  = 20
    }
  }

  network_interface {
    network    = var.vpc_link
    subnetwork = var.subnet_link

    # Optional external IP for SSH from outside
    access_config {}
  }

  metadata = {
    # ssh-keys = "your-username:${file("~/.ssh/id_rsa.pub")}"
  }

  tags = ["bastion"]
}

# Firewall rule to allow SSH into bastion
resource "google_compute_firewall" "bastion-ssh" {
  name    = "allow-ssh-bastion"
  network = var.vpc_link
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Restrict SSH only to your home/public IP (replace with your IP)
  source_ranges = ["103.84.81.29/32"]

  target_tags = ["bastion"]

  depends_on = [ google_compute_instance.bastion ]
}

# Allow IAP TCP:22 traffic
resource "google_compute_firewall" "iap-ssh" {
  name    = "allow-iap-ssh"
  network = var.vpc_link
  project = var.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # IAP IP range
  source_ranges = ["35.235.240.0/20"]

  target_tags = ["bastion"]
  depends_on = [ google_compute_instance.bastion ]

}
