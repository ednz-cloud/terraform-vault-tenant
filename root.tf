locals {
  root_policy_default_rules = {
    tenant_prefix_rw = {
      path         = "${var.prefix}/*"
      capabilities = ["create", "update", "read", "delete", "list"]
    }
    tenant_prefix_mount = {
      path         = "sys/mounts/${var.prefix}/*"
      capabilities = ["create", "update", "read", "delete", "list"]
    }
    tenant_prefix_remount = {
      path         = "sys/remount"
      capabilities = ["update", "sudo"]
      allowed_parameters = {
        "from" = ["${var.prefix}/*"]
        "to"   = ["${var.prefix}/*"]
      }
    }
    tenant_prefix_remount_status = {
      path         = "sys/remount/status/*"
      capabilities = ["read"]
    }
  }
  root_policy_rules = merge(local.root_policy_default_rules, var.root_policy_extra_rules)
}

# data "vault_policy_document" "root" {
#   dynamic "rule" {
#     for_each = local.root_policy_rules
#     content {
#       path                = each.value.path
#       capabilities        = each.value.capabilities
#       description         = try(each.value.description, null)
#       required_parameters = try(each.value.required_parameters, null)
#       allowed_parameter   = try(each.value.allowed_parameter, null)
#       denied_parameter    = try(each.value.denied_parameter, null)
#       min_wrapping_ttl    = try(each.value.min_wrapping_ttl, null)
#       max_wrapping_ttl    = try(each.value.max_wrapping_ttl, null)
#     }
#   }
# }

data "vault_policy_document" "root" {
  dynamic "rule" {
    for_each = local.root_policy_rules
    content {
      path                = rule.value.path
      capabilities        = rule.value.capabilities
      description         = try(rule.value.description, null)
      min_wrapping_ttl    = try(rule.value.min_wrapping_ttl, null)
      max_wrapping_ttl    = try(rule.value.max_wrapping_ttl, null)
      required_parameters = try(rule.value.required_parameters, null)

      # dynamic "required_parameters" {
      #   for_each = rule.value.required_parameters != null ? rule.value.required_parameters : {}
      #   content {
      #     key = required_parameters.key
      #     value = required_parameters.value
      #   }
      # }

      dynamic "allowed_parameter" {
        for_each = try(rule.value.allowed_parameter, {}) != {} ? rule.value.allowed_parameter : {}
        content {
          key   = allowed_parameter.key
          value = allowed_parameter.value
        }
      }

      dynamic "denied_parameter" {
        for_each = try(rule.value.denied_parameter, {}) != {} ? rule.value.denied_parameter : {}
        content {
          key   = denied_parameter.key
          value = denied_parameter.value
        }
      }
    }
  }
}

resource "vault_policy" "root" {
  name   = "${var.name}-root"
  policy = data.vault_policy_document.root.hcl
}

resource "vault_approle_auth_backend_role" "root" {
  backend        = vault_auth_backend.approle.path
  role_name      = "${var.name}-root"
  token_policies = ["default", vault_policy.root.name]
}

resource "random_uuid" "root_secret_id" {}

resource "vault_approle_auth_backend_role_secret_id" "root" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.root.role_name
  secret_id = random_uuid.root_secret_id.result
}

resource "vault_identity_entity" "root" {
  name = "${var.prefix}-root"
}

resource "vault_identity_entity_alias" "root" {
  name           = vault_approle_auth_backend_role.root.role_id
  mount_accessor = vault_auth_backend.approle.accessor
  canonical_id   = vault_identity_entity.root.id
}
