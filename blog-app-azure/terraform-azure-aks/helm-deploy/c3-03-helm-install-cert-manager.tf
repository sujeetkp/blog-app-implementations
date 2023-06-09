resource "helm_release" "cert_manager" {

  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "1.12.0"
  
  namespace = var.cert_manager_namespace
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "securityContext.enabled"
    value = "true"
  }

  atomic = true
  wait = true
  
}