variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "roles" {
  type = list(string)
}

# variable "master_ipv4_cidr" {
#   type = string
# }

variable "project_id" {
  type = string
}

variable "node_machine_type" {
  type = string
}

variable "node_count" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_link" {
  type = string
}

variable "subnet_link" {
  type = string
}

variable "service_acc" {
  type = string
}