resource "vault_policy" "extra_policies" {
  for_each = var.tenant_additional_roles

  name   = "${var.tenant_prefix}-${each.key}"
  policy = file(each.value.policy_file)
}

resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "${var.tenant_prefix}-approle"
  tune {
    default_lease_ttl = "3600s"
    max_lease_ttl     = "14400s"
  }
}

resource "vault_approle_auth_backend_role" "extra_roles" {
  for_each = var.tenant_additional_roles

  backend        = vault_auth_backend.approle.path
  role_name      = each.key
  token_policies = ["default", "${vault_policy.extra_policies[each.key].name}"]
}

resource "random_uuid" "extra_roles_secret_id" { for_each = var.tenant_additional_roles }

resource "vault_approle_auth_backend_role_secret_id" "extra_roles" {
  for_each = var.tenant_additional_roles

  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.extra_roles[each.key].role_name
  secret_id = random_uuid.extra_roles_secret_id[each.key].result
}

resource "vault_identity_entity" "extra_roles" {
  for_each = var.tenant_additional_roles

  name = "${var.tenant_prefix}-${each.key}"
  metadata = {
    tenant = var.tenant_name
    prefix = var.tenant_prefix
  }
}
