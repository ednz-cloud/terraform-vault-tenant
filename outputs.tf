output "tenant_admin_role" {
  value = {
    role_id   = vault_approle_auth_backend_role.tenant_admin.role_name
    secret_id = vault_approle_auth_backend_role_secret_id.tenant_admin.secret_id
  }
  sensitive   = true
  description = "The tenant admin approle role"
  depends_on = [
    vault_approle_auth_backend_role.tenant_admin,
    vault_approle_auth_backend_role_secret_id.tenant_admin
  ]
}

output "tenant_admin_policy" {
  value       = vault_policy.tenant_admin.name
  sensitive   = false
  description = "The tenant admin policy name"
  depends_on  = [vault_policy.tenant_admin]
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
