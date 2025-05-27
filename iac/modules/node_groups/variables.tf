variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_api_server_url" {
  type = string
}

variable "eks_cluster_ca" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "node_groups_configs" {}
variable "subnet_ids" {}