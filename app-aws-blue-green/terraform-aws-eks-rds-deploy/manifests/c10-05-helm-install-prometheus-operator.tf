resource "helm_release" "prometheus-operator" {
  
  depends_on = [
    module.eks
  ]

  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  
  namespace = var.prometheus_namespace
  create_namespace = true

  wait = true
  timeout = 600
  
}