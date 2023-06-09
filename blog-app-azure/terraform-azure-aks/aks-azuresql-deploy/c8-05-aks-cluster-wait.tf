resource "time_sleep" "wait_seconds" {

  depends_on = [
    module.aks
  ]

  create_duration = "5m"

}
