resource "vault_approle_auth_backend_role" "root" {
  backend        = vault_auth_backend.approle.path
  role_name      = "${var.name}-root"
  token_policies = ["default", vault_policy.root.name]
}

resource "random_uuid" "root_secret_id" {}

resource "vault_approle_auth_backend_role_secret_id" "root" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.root.role_name
  secret_id = random_uuid.root_secret_id.result
}

resource "vault_policy" "root" {
  name   = "${var.name}-root"
  policy = var.root_policy_file == null ? templatefile("${path.module}/policies/root.policy.hcl", { tenant_prefix = var.prefix }) : file(var.root_policy_file)
}

resource "vault_identity_entity" "root" {
  name = "${var.prefix}-root"
}

resource "vault_identity_entity_alias" "root" {
  name           = vault_approle_auth_backend_role.root.role_id
  mount_accessor = vault_auth_backend.approle.accessor
  canonical_id   = vault_identity_entity.root.id
}
