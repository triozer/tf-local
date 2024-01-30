variable "kind_cluster_name" {
  type        = string
  description = "Name of the Kind cluster"
  default     = "local"
}

variable "kind_config_path" {
  type        = string
  description = "Path to the Kind cluster config file"
  default     = "~/.kube/config"
}

# variable "vault_username" {
#   type = string
#   description = "Vault admin username"
# }

# variable "vault_password" {
#   type = string
#   description = "Vault admin password"
# }