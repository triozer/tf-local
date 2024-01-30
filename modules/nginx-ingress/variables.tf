variable "kind_config_path" {
  type        = string
  description = "Path to the Kind cluster config file"
  default     = "~/.kube/config"
}

variable "kind_cluster" {
  description = "Kind cluster resource"
}
