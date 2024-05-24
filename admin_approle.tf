resource "vault_approle_auth_backend_role" "tenant_admin" {
  backend        = var.global_approle_mount
  role_name      = "${var.tenant_name}-admin"
  token_policies = ["default", "${vault_policy.tenant_admin.name}"]
}

resource "random_uuid" "tenant_admin_secret_id" {}

resource "vault_approle_auth_backend_role_secret_id" "tenant_admin" {
  backend   = var.global_approle_mount
  role_name = vault_approle_auth_backend_role.tenant_admin.role_name
  secret_id = random_uuid.tenant_admin_secret_id.result
}

resource "vault_identity_entity" "tenant_admin" {
  name = "${each.value.prefix}-admin"
  metadata = {
    tenant = var.tenant_name
    prefix = var.tenant_prefix
  }
}

resource "vault_policy" "tenant_admin" {
  name   = "${var.tenant_name}-admin"
  policy = file(var.tenant_admin_policy_file)
}
