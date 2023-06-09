locals{
  external_dns_service_account = var.iam_role_external_dns
}

module "iam_role_external_dns" {

  depends_on = [
    module.iam_policy
  ]
  
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "5.20.0"

  create_role = true

  role_name = var.iam_role_external_dns

  provider_url = local.provider_url

  role_policy_arns = [module.iam_policy.arn]

  oidc_fully_qualified_subjects = ["system:serviceaccount:${var.external_dns_namespace}:${local.external_dns_service_account}"]
  
}

output "external_dns_role_arn" {
  value = module.iam_role_external_dns.iam_role_arn
}