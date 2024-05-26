resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "${var.tenant_prefix}-approle"
  tune {
    default_lease_ttl = "3600s"
    max_lease_ttl     = "14400s"
  }
}

resource "vault_identity_group_alias" "this" {
  name           = var.tenant_name
  mount_accessor = vault_auth_backend.approle.accessor
  canonical_id   = vault_identity_group.this.id
}
