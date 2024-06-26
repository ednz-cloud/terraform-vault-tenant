path "${tenant_prefix}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "sys/mounts/${tenant_prefix}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "sys/remount" {
  capabilities = ["update", "sudo"]
  allowed_parameters = {
    "from" = ["${tenant_prefix}/*"]
    "to" = ["${tenant_prefix}/*"]
  }
}

path "sys/remount/status/*" {
  capabilities = ["read"]
}
