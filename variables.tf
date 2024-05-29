variable "name" {
  type        = string
  description = "The name of the tenant you want to create"
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]*$", var.name))
    error_message = "The tenant name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "prefix" {
  type        = string
  description = "The prefix to use for the tenant in vault (this will prefix mount points, policies, etc..)"
}

variable "additional_roles" {
  type        = map(string)
  default     = {}
  description = <<EOT
    A map of additional role names, with the path to the associated policy file to add for this tenant.
    A separate approle auth method is created for this tenant (mounted at auth/<prefix>-approle) including all the roles declared in this variable.
    The variable should look like:
    additional_roles = {
      devs = file("path/to/policy.hcl")
      admins = data.vault_policy_document.admins.hcl
    }
  EOT
}

variable "root_policy_extra_rules" {
  type = map(
    object({
      path                = string
      capabilities        = list(string)
      description         = optional(string)
      required_parameters = optional(map(list(any)))
      allowed_parameter   = optional(map(list(any)))
      denied_parameter    = optional(map(list(any)))
      min_wrapping_ttl    = optional(number)
      max_wrapping_ttl    = optional(number)
    })
  )
  description = "A map of additional policies to attach to the root policy. These are merged with the default policies for the root role so that you can customize it to your needs"
  default     = {}
}
