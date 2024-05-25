# terraform-vault-tenant

This module aims to provide a way for companies and individuals running the community version of vault, to segregate accesses between teams.

This "tenant" module requires that you have at least one approle auth method mounted prior to deploying it. It will create a tenant admin approle role on these mount, and apply the policy you define. It can also create an additional tenant-scoped approle auth mount, and create roles based on policies that you define.

The idea behind this is that outside of access control, a tenant is free to create whatever secret engine, secrets, etc... As long as those are prefixed with their tenant prefix.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.0 |
| <a name="requirement_random"></a> [random](#requirement_random) | ~> 3.6.2 |
| <a name="requirement_vault"></a> [vault](#requirement_vault) | ~> 4.2.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider_random) | ~> 3.6.2 |
| <a name="provider_vault"></a> [vault](#provider_vault) | ~> 4.2.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [random_uuid.extra_roles_secret_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.tenant_admin_secret_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [vault_approle_auth_backend_role.extra_roles](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role.tenant_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role_secret_id.extra_roles](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_approle_auth_backend_role_secret_id.tenant_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_auth_backend.approle](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_identity_entity.extra_roles](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_identity_entity.tenant_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_policy.extra_policies](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.tenant_admin](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_global_approle_mount"></a> [global_approle_mount](#input_global_approle_mount) | The mount path for the global AppRole authentication method | `string` | `"approle"` | no |
| <a name="input_tenant_additional_roles"></a> [tenant_additional_roles](#input_tenant_additional_roles) | A map of additional role names, with the path to the associated policy file to add for this tenant.<br>    A separate approle auth method is created for this tenant (mounted at auth/<prefix>-approle) including all the roles declared in this variable.<br>    The variable should look like:<br>    tenant_additional_roles = {<br>      devs = {<br>        policy_file = "/some/path/to/policy.hcl"<br>      }<br>      admins = {...}<br>    } | <pre>map(object({<br>    policy_file = string<br>  }))</pre> | `{}` | no |
| <a name="input_tenant_admin_policy_file"></a> [tenant_admin_policy_file](#input_tenant_admin_policy_file) | The path to the admin policy file for this tenant | `string` | `null` | no |
| <a name="input_tenant_name"></a> [tenant_name](#input_tenant_name) | The name of the tenant you want to create | `string` | n/a | yes |
| <a name="input_tenant_prefix"></a> [tenant_prefix](#input_tenant_prefix) | The prefix to use for the tenant in vault (this will prefix mount points, policies, etc..) | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_extra_role_policies"></a> [extra_role_policies](#output_extra_role_policies) | The tenant extra role policy names |
| <a name="output_extra_roles"></a> [extra_roles](#output_extra_roles) | The tenant extra approle roles |
| <a name="output_tenant_admin_policy"></a> [tenant_admin_policy](#output_tenant_admin_policy) | The tenant admin policy name |
| <a name="output_tenant_admin_role"></a> [tenant_admin_role](#output_tenant_admin_role) | The tenant admin approle role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
