# InfinumAzure Engine

InfinumAzure Engine is gem for resource authentication with Infinum Azure AD server.

## Table of Contents
- [Installation](#installation)
- [Dependencies](#dependencies)
- [Configuration](#configuration)
  * [InfinumAzure](#infinumazure)
  * [Secrets](#secrets)
- [Usage](#usage)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'infinum_azure'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install infinum_azure

## Dependencies

* [Devise](https://github.com/plataformatec/devise)
* [Omniauth::InfinumAzure](https://github.com/infinum/ruby-infinum-azure-omniauth)

## Configuration

### InfinumAzure

```ruby
# config/initializers/infinum_azure.rb

InfinumAzure.configure do |config|
  config.service_name = 'Revisor'
  config.resource_name = 'User'
  config.resource_attributes = [:uid, :email, :first_name, :last_name, :avatar_url,
                                :deactivated_at, :provider_groups, :employee]

  config.user_migration_scope = -> { resource_class.where(provider: 'infinum_id') }
  config.user_migration_operation = > (record, resource) {
    record.update_attribute(:provider, 'infinum_azure')
    record.update_attribute(:uid, resource['Uid'])
  }
end
```

Configuration options:
* service_name(mandatory) - name of application
* resource_name(mandatory) - name of resource on whom authentication is being done
* resource_attributes(optional) - attributes that will be permitted once the webhook controller receives the params from InfinumAzure
* user_migration_scope(optional) - a block that will be used to get the initial collection of resources (if blank, default is written above)
* user_migration_operation(optional) - a block that will be called for each resource from the above collection if a matching resource on InfinumAzure is found. The resource is a Hash containing the following properties:
  * `Uid` - string
  * `FirstName` - string || null
  * `LastName` - string || null
  * `Email` - string
  * `AvatarUrl` - string || null
  * `UserGroup` - string || null -> a comma separated list; if "employees" is present, the user is an employee
  * `Deactivated` - boolean

### Secrets

Secrets should be kept in `config/secrets.yml` file.

Required ones are:

```ruby
# config/secrets.yml

infinum_azure:
  client_id: 'client_id_from_InfinumAzure'
  client_secret: 'client_secret_from_InfinumAzure'
  tenant: 'InfinumAzure_tenant'
```

Optional ones are:

```ruby
infinum_azure:
  users_auth_url: 'InfinumAzure_users_auth_url_with_api_code' # required only if infinum_azure:migrate_users rake task is used
```

## Usage

1. Add columns to resource via migration.

<b>Required columns:</b>
* *email* _string_
* *uid* _string_
* *provider* _string_
* *remember_created_at* _datetime_
* *remember_token* _string_

<b>Optional columns:</b>
* *first_name* _string_
* *last_name* _string_
* *avatar_url* _string_
* *deactivated_at* _datetime_
* *provider_groups* _jsonb array_
* *employee* _boolean_

2. Add following rows to resource model:

```ruby
devise :rememberable, :omniauthable, omniauth_providers: [:infinum_azure]

def remember_me
  true
end
```

_NOTE_: The `#remember_me` method needs to always return *true* in order for users to stay logged in after they shut down their browsers. In case your app has a checkbox for `Remember me` on the login page next to the login button, you can override the return value.

3. Use devise's method `#authenticate_user!` to authenticate users on API endpoints

```ruby
class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
end
```

4. In case your model is named `User`, you can use the `#user_infinum_azure_omniauth_authorize_path` for the login button:

```ruby
button_to 'Login', user_infinum_azure_omniauth_authorize_path
```

5. In case you want logging out, you can use `#infinum_azure_logout_path` for logging out of Infinum Azure and your app:

```ruby
link_to 'Logout', infinum_azure_logout_path
```

or, if you just want to clear the session, but not log out of Infinum Azure, you can use:

```ruby
link_to 'Logout', logout_path
```

## Known issues

If you don't get what you're looking for, check your terminal output and see if omniauth logs are saying anything similar to:

```
DEBUG -- omniauth: (google_oauth2) Request phase initiated.
WARN -- omniauth: Attack prevented by OmniAuth::AuthenticityTokenProtection
ERROR -- omniauth: (google_oauth2) Authentication failure! authenticity_error: OmniAuth::AuthenticityError, Forbidden
```

To resolve this issue, install the omniauth-rails_csrf_protection gem:

```ruby
gem 'omniauth-rails_csrf_protection'
```

Make sure to use HTTP method POST for authenticating. If you are using a link, you can set the HTTP method to POST like this:

```ruby
link_to 'Login', user_infinum_azure_omniauth_authorize_path, method: :post
```

or, simply with `#button_to` as mentioned above.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
