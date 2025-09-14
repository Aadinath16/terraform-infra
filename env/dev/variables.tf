variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "environment" {
  type = string
}

variable "api_list" {
  type = list(string)
}

variable "subnet_cidr" {
  type = string
}

variable "pods_cidr" {
  type = string
}

variable "services_cidr" {
  type = string
}

# variable "master_ipv4_cidr" {
#   type = string
# }

variable "cluster_name" {
  type = string
}

variable "node_machine_type" {
  type = string
}

variable "node_count" {
  type = string
}

variable "service_account_roles" {
  type = list(string)
}