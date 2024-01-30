provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kind_config_path)
  }
}

resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.7.5"

  namespace        = "ingress-nginx"
  create_namespace = true

  values = [file("${path.module}/values/nginx-ingress.yaml")]

  depends_on = [var.kind_cluster]
}

resource "null_resource" "wait_for_ingress_nginx" {
  triggers = {
    key = uuid()
  }

  provisioner "local-exec" {
    command = "kubectl wait --namespace ${helm_release.ingress_nginx.namespace} --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s"
  }

  depends_on = [helm_release.ingress_nginx]
}
