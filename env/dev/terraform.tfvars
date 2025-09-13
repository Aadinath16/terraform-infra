project_id  = "gcp-test-123"
region      = "us-central1"
zone        = "us-central1-a"
environment = "dev"

api_list = ["cloudresourcemanager.googleapis.com",
  "serviceusage.googleapis.com",
  "container.googleapis.com",
  "artifactregistry.googleapis.com",
  "compute.googleapis.com",
  "iam.googleapis.com",
  "servicenetworking.googleapis.com",
  "logging.googleapis.com",
"monitoring.googleapis.com"]

subnet_cidr = "10.10.0.0/20"

pods_cidr = "10.20.0.0/16"

services_cidr = "10.30.0.0/20"

# master_ipv4_cidr = "172.16.0.0/28"

cluster_name = "gke"

node_machine_type = "e2-small"

node_count = "1"


service_account_roles = [
  # "roles/iam.serviceAccountUser",
  "roles/compute.instanceAdmin.v1",
  "roles/logging.logWriter",
  "roles/monitoring.metricWriter"
]


  # "roles/container.nodeServiceAccount",