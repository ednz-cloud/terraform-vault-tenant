resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "${var.tenant_prefix}/approle"
  tune {
    default_lease_ttl = "3600s"
    max_lease_ttl     = "14400s"
  }
}

resource "vault_identity_group" "this" {
  name = var.tenant_name
  type = "internal"
  metadata = {
    tenant = var.tenant_name
    prefix = var.tenant_prefix
  }
}
