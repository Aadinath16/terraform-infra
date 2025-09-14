module "common" {
  source      = "../../modules/common"
  project_id  = "${var.project_id}-${var.environment}"
  region      = var.region
  environment = var.environment
  api_list    = var.api_list
}

module "network" {
  source        = "../../modules/network"
  project_id    = "${var.project_id}-${var.environment}"
  region        = var.region
  environment   = var.environment
  subnet_cidr   = var.subnet_cidr
  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr
  depends_on    = [module.service-account]
}


module "service-account" {
  source       = "../../modules/service-account"
  project_id   = "${var.project_id}-${var.environment}"
  roles        = var.service_account_roles
  environment  = var.environment
  account_id   = "dev-node-sa"
  display_name = "Dev Node Service Account"
  depends_on   = [module.common]

}

module "gke" {
  source            = "../../modules/gke"
  project_id        = "${var.project_id}-${var.environment}"
  region            = var.region
  zone              = var.zone
  environment       = var.environment
  cluster_name      = "${var.cluster_name}-${var.environment}"
  node_count        = var.node_count
  node_machine_type = var.node_machine_type
  vpc_link          = module.network.vpc_self_link
  subnet_link       = module.network.subnet_self_link
  service_acc       = module.service-account.service_acc_name
  depends_on        = [module.network]
}