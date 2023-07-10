## [Unreleased]

## [0.4.3] - 2023-07-10

- Fix bug: Use pluralized resource_name for generating the logout paths

## [0.4.2] - 2023-06-20

- Fix bug: Always set `provider` to "infinum_azure" in default #user_migration_operation
## [0.4.1] - 2023-06-20

- Remove `Value` JSON wrapper from Azure Users API response

## [0.4.0] - 2023-06-15

- Slim down the gem (remove dependencies and transient dependencies):
  - dry-configurable
  - http
  - responders
- Add `avatar_url`, `deactivated_at`, `provider_groups` and `employee` as selectable *resource_attributes*
- Add rake task `infinum_azure:migrate_users` for migrating users (updating `uid` values from Infinum ID to Infinum Azure)
- Update Readme

## [0.3.0] - 2023-04-21

- Fix upserting new resource memoization

## [0.2.1] - 2023-04-20

- Added after_upsert_resource & called it in upsert webhook API after the action

## [0.2.0] - 2023-04-20

- Added upsert webhook API for creating/updating resources

## [0.1.0] - 2023-03-15

- Initial release
