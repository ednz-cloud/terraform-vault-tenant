path "${tenant_prefix}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "sys/mounts/${tenant_prefix}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "auth/token/create" {
  capabilities = ["create", "update", "delete"]
  allowed_parameters = {
    "policies" = [${admin_policies}, ${reverse(admin_policies)}]
  }
}
