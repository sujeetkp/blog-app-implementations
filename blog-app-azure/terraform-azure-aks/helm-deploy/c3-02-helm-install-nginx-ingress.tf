resource "helm_release" "nginx_ingress_controller" {

  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  create_namespace = true
  namespace = var.nginx_ingress_namespace
  
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
  
  atomic = true
  wait = true
  
}
