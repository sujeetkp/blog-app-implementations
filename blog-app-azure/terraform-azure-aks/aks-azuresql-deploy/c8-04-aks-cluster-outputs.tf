output "aks_cluster_name" {
  value = module.aks.aks_name
}

output "aks_oidc_issuer_url" {
  value = module.aks.oidc_issuer_url
}

output "aks_kubelet_managed_identity_principal_id" {
  value = module.aks.kubelet_identity.0.object_id
}