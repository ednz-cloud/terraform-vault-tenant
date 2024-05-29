resource "vault_approle_auth_backend_role" "extra" {
  for_each = var.additional_roles

  backend        = vault_auth_backend.approle.path
  role_name      = each.key
  token_policies = ["default", "${vault_policy.extra[each.key].name}"]
}

resource "random_uuid" "extra_secret_id" { for_each = var.additional_roles }

resource "vault_approle_auth_backend_role_secret_id" "extra" {
  for_each = var.additional_roles

  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.extra[each.key].role_name
  secret_id = random_uuid.extra_secret_id[each.key].result
}

resource "vault_policy" "extra" {
  for_each = var.additional_roles

  name   = "${var.prefix}-${each.key}"
  policy = each.value
}

resource "vault_identity_entity" "extra" {
  for_each = var.additional_roles

  name = "${var.prefix}-${each.key}"
}

resource "vault_identity_entity_alias" "extra" {
  for_each = var.additional_roles

  name           = vault_approle_auth_backend_role.extra[each.key].role_id
  mount_accessor = vault_auth_backend.approle.accessor
  canonical_id   = vault_identity_entity.extra[each.key].id
}
