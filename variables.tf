variable "global_approle_mount" {
  type        = string
  default     = "approle"
  description = "The mount path for the global AppRole authentication method"
}

variable "tenant_name" {
  type        = string
  description = "The name of the tenant you want to create"
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]*$", var.tenant_name))
    error_message = "The tenant name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "tenant_prefix" {
  type        = string
  description = "The prefix to use for the tenant in vault (this will prefix mount points, policies, etc..)"
}

variable "tenant_admin_policy_file" {
  type        = string
  default     = "./policies/tenant-admins.policy.hcl"
  description = "The path to the admin policy file for this tenant"
}

variable "tenant_additional_roles" {
  type = map(object({
    policy_file = string
  }))
  default     = {}
  description = <<EOT
    A map of additional role names, with the path to the associated policy file to add for this tenant.
    A separate approle auth method is created for this tenant (mounted at auth/<prefix>-approle) including all the roles declared in this variable.
    The variable should look like:
    tenant_additional_roles = {
      devs = {
        policy_file = "/some/path/to/policy.hcl"
      }
      admins = {...}
    }
  EOT
}
