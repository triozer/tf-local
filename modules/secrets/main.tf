provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kind_config_path)
  }
}

resource "helm_release" "consul" {
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  version    = "1.3.2"

  namespace        = "secrets"
  create_namespace = true

  values = [file("${path.module}/values/consul.yaml")]

  depends_on = [var.kind_cluster]
}

resource "helm_release" "vault" {
  name       = "vault"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "vault"
  version    = "0.27.0"

  namespace        = "secrets"
  create_namespace = true

  values = [file("${path.module}/values/vault.yaml")]

  depends_on = [helm_release.consul]
}
