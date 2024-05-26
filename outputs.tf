output "approle_mount" {
  value       = vault_auth_backend.approle
  sensitive   = true
  description = "The approle mount for the tenant"
}


output "root_role" {
  value = {
    role_id   = vault_approle_auth_backend_role.root.role_name
    secret_id = vault_approle_auth_backend_role_secret_id.root.secret_id
  }
  sensitive   = true
  description = "The tenant root approle role"
  depends_on = [
    vault_approle_auth_backend_role.root,
    vault_approle_auth_backend_role_secret_id.root
  ]
}

output "root_policy" {
  value       = vault_policy.root.name
  sensitive   = false
  description = "The tenant root policy name"
  depends_on  = [vault_policy.root]
}

output "extra_roles" {
  value = {
    for key, role in vault_approle_auth_backend_role.extra_roles :
    key => {
      role_id   = role.role_name
      secret_id = vault_approle_auth_backend_role_secret_id.extra_roles[key].secret_id
    }
  }
  sensitive   = true
  description = "The tenant extra approle roles"
  depends_on = [
    vault_approle_auth_backend_role.extra_roles,
    vault_approle_auth_backend_role_secret_id.extra_roles
  ]
}

output "extra_role_policies" {
  value = {
    for key, policy in vault_policy.extra_policies :
    key => policy.name
  }
  sensitive   = false
  description = "The tenant extra role policy names"
  depends_on  = [vault_policy.extra_policies]
}
