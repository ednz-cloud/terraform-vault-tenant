path "{{identity.entity.metadata.prefix}}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "sys/mounts/{{identity.entity.metadata.prefix}}/*" {
  capabilities = ["create", "update", "read", "delete", "list"]
}

path "auth/token/create" {
  capabilities = ["create", "update", "sudo"]
}
