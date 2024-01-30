provider "kind" {}

provider "kubernetes" {
  config_path = pathexpand(var.kind_config_path)
}

resource "kind_cluster" "default" {
  name            = var.kind_cluster_name
  kubeconfig_path = pathexpand(var.kind_config_path)
  node_image      = "kindest/node:v1.28.0"
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"

      kubeadm_config_patches = [
        "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
      ]

      extra_port_mappings {
        container_port = 80
        host_port      = 80
        listen_address = "0.0.0.0"
      }

      extra_port_mappings {
        container_port = 443
        host_port      = 443
        listen_address = "0.0.0.0"
      }
    }

    node {
      role = "worker"
    }
  }
}

module "nginx-ingress" {
  source = "./modules/nginx-ingress"

  kind_config_path = var.kind_config_path
  kind_cluster     = kind_cluster.default
}

module "secrets" {
  source = "./modules/secrets"

  kind_config_path = var.kind_config_path
  kind_cluster     = kind_cluster.default
}
