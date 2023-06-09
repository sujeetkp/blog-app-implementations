/* NOT REQUIRED AS KUBELET MANAGED IDENTITY WILL BE USED
resource "time_sleep" "wait_seconds_oidc" {

  depends_on = [
    azurerm_federated_identity_credential.aks_external_dns_oidc
  ]

  create_duration = "5m"

}
*/