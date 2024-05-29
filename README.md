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
| [random_uuid.extra_secret_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [random_uuid.root_secret_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [vault_approle_auth_backend_role.extra](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_approle_auth_backend_role_secret_id.extra](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_approle_auth_backend_role_secret_id.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role_secret_id) | resource |
| [vault_auth_backend.approle](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_identity_entity.extra](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_identity_entity.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity) | resource |
| [vault_identity_entity_alias.extra](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity_alias) | resource |
| [vault_identity_entity_alias.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_entity_alias) | resource |
| [vault_identity_group.this](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/identity_group) | resource |
| [vault_policy.extra](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy_document.root](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/policy_document) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_roles"></a> [additional_roles](#input_additional_roles) | A map of additional role names, with the path to the associated policy file to add for this tenant.<br>    A separate approle auth method is created for this tenant (mounted at auth/<prefix>-approle) including all the roles declared in this variable.<br>    The variable should look like:<br>    additional_roles = {<br>      devs = file("path/to/policy.hcl")<br>      admins = data.vault_policy_document.admins.hcl<br>    } | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input_name) | The name of the tenant you want to create | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input_prefix) | The prefix to use for the tenant in vault (this will prefix mount points, policies, etc..) | `string` | n/a | yes |
| <a name="input_root_policy_extra_rules"></a> [root_policy_extra_rules](#input_root_policy_extra_rules) | A map of additional policies to attach to the root policy. These are merged with the default policies for the root role so that you can customize it to your needs | <pre>map(<br>    object({<br>      path                = string<br>      capabilities        = list(string)<br>      description         = optional(string)<br>      required_parameters = optional(list(string))<br>      allowed_parameter   = optional(map(list(any)))<br>      denied_parameter    = optional(map(list(any)))<br>      min_wrapping_ttl    = optional(number)<br>      max_wrapping_ttl    = optional(number)<br>    })<br>  )</pre> | `{}` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_approle_mount"></a> [approle_mount](#output_approle_mount) | The approle mount for the tenant |
| <a name="output_extra_role_policies"></a> [extra_role_policies](#output_extra_role_policies) | The tenant extra role policy names |
| <a name="output_extra_roles"></a> [extra_roles](#output_extra_roles) | The tenant extra approle roles |
| <a name="output_root_policy"></a> [root_policy](#output_root_policy) | The tenant root policy name |
| <a name="output_root_role"></a> [root_role](#output_root_role) | The tenant root approle role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
