path "${tenant_prefix}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "sys/mounts/${tenant_prefix}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}
