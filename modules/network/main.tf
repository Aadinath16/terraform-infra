resource "google_compute_network" "vpc_network" {
  name = "${var.environment}-vpc"
  project = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.environment}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  project       = var.project_id

  secondary_ip_range {
    range_name = "pods-range"
    ip_cidr_range = var.pods_cidr
  }


  secondary_ip_range {
    range_name = "services-range"
    ip_cidr_range = var.services_cidr
  }

}


#Cloud Router and NAT
resource "google_compute_router" "nat_router" {
  name = "nat-router"
  network = google_compute_network.vpc_network.name
  project = var.project_id
  region = var.region
}


resource "google_compute_router_nat" "nat_config" {
  name = "nat-config"
  project = var.project_id
  router = google_compute_router.nat_router.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}