/* External DNS MI - Kubelete Managed Identity will be uded
variable "aks_external_dns_mi_name" {
  description = "Azure Kubernetes External DNS Managed Identity"
  type = string
}
*/

variable "nginx_ingress_namespace" {
  description = "nginx ingress namespace"
  type = string
}

variable "cert_manager_namespace" {
  description = "cert manager namespace"
  type = string
}

variable "external_dns_namespace" {
  description = "External DNS Namespace "
  type = string
}

variable "prometheus_operator_namespace" {
  description = "Prometheus Operator Namespace "
  type = string
}

variable "public_domain_name" {
  description = "Public Domain Name"
  type = string
}

variable "public_domain_rg" {
  description = "Public Domain Resource Group"
  type = string
}

