## v0.2.0 (2024-05-29)

### Feat

- pass extra roles as key value pairs, required the full policy as value
- allow passing extra policies to the tenant root role, start migrating away from old 'extra roles' approach

### Fix

- required_parameters type in root_policy_extra_rules
- required_parameters type in root_policy_extra_rules
- evaluate parameters against null to avoid failing when null values are injected in place of optionals
- typo in default root permissions
- use try on dynamic block to not raise errors on non-existent attributes
- use rule context for block scoped values
- adjust code for root policy document to generate blocks instead of map of lists

## v0.1.0 (2024-05-28)

### Feat

- refactor module, simplify naming and create additional entities for extra roles
- create entities for each extra policies
- change approle path to <prefix>/approle instead of <prefix>-approle
- move every approle role to dedicated backend, and add group to pass metadata along
- allow tenant admin to remount secret engines on tenant prefix
- only allow tenant admin to create tokens with its own policies
- allow tenant admin to create child token with its own permissions
- add default admin policy
- add version constraint to terraform providers
- add outputs to module for policy names and role details
- add first roles and approle auth method for tenant

### Fix

- adjust .cz.toml which uses wrong tagging convention and useless options
- some more old naming things
- outputs using old reosurce naming
- variable validation using old names
- make tenant group external
- remove duplicate resource
- remove duplicate resource
- remount needs sudo
- increase permissions for remounting secret engines
- wrong allowed_parameters type for params
- revert using locals for role policies
- do not allow any token creation for now, will have to avoid child tokens in tf provider config
- templating not working for arrays
- circular dependency
- template of policy file
- wrong permissions on token policy for tenant admin
- wrong permissions on token/create for tenant admin
- wrong permissions on token/create for tenant admin
- default policy file path for admin to null, and use built-in policy if value stays null
- wrong variable name in admin entity
