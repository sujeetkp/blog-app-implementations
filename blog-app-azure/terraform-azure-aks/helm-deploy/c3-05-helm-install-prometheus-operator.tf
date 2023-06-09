resource "helm_release" "prometheus_operator" {
 
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  
  namespace        = var.prometheus_operator_namespace
  create_namespace = true

  atomic = true
  wait = true
  timeout = 600
  
}