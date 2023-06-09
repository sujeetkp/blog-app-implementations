resource "helm_release" "metrics-server" {
  
  depends_on = [
    module.eks
  ]

  name       = "metrics-server"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "metrics-server"
  
  namespace = "kube-system"

  set {
    name  = "apiService.create"
    value = "true"
  }

  wait = true
  
}