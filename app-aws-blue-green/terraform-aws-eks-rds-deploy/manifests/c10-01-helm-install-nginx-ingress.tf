resource "helm_release" "nginx_ingress_controller" {
depends_on = [
  module.eks,
  helm_release.aws-load-balancer-controller
]
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  namespace = var.nginx_ingress_namespace
  create_namespace = true

  values = [
    "${file("config-files/nginx-ingress-controller-values.yml")}"
  ]

  wait = true
  
}
