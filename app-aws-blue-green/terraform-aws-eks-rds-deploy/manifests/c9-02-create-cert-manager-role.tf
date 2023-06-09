locals{
  cert_manager_service_account = var.iam_role_cert_manager
}

module "iam_role_cert_manager" {

  depends_on = [
    module.iam_policy
  ]
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.20.0"

  create_role = true

  role_name = var.iam_role_cert_manager

  provider_url = local.provider_url

  role_policy_arns = [module.iam_policy.arn]

  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.cert_manager_namespace}:${local.cert_manager_service_account}"]

}

output "cert_manager_role_arn" {
  value = module.iam_role_cert_manager.iam_role_arn
}