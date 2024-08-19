## [Unreleased]

## [3.1.0] - 2024-08-16

### Changed
- Change provider_groups to groups and add groups attribute to Params

## [3.0.0] - 2024-06-12
**BREAKING CHANGE**
- Remove `service_name` option from the configuration
- Added mandatory configuration options `client_id`, `client_secret`, `domain`, and `tenant`

### Changed
- Remove dependency on Rails secrets and enable clients to choose how to manage secret parameters

### Added
- RuboCop gems `factory_bot`, `infinum`, `rake`, `rspec_rails`
- GitHub Actions to build app image and run checks

### Fixed
- RuboCop offenses 

## [2.0.0] - 2024-03-12

**BREAKING CHANGE**
- Add `domain` client option - versions that use the transient dependency `omniauth-infinum_azure` prior to version 1 will not break, but are deprecated and will raise errors in version 2

## [1.1.0] - 2023-07-10

- Fix bug: Use pluralized resource_name for generating the logout paths

## [1.0.0] - 2023-06-20

#### Breaking change

This change switches from using the `email` as a match for finding which user logged in to `uid` and `provider`. Before you move to 1.0.0 usage, you need to ensure your user data has been migrated to Infinum Azure. Ensure all `uid` values are updated and `provider` is set to "infinum_azure".

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
