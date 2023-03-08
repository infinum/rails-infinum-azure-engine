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
* [Dry configurable](https://github.com/dry-rb/dry-configurable)
* [Http](https://github.com/httprb/http)
* [Omniauth::InfinumAzure](https://github.com/infinum/ruby-infinum-azure-omniauth)

## Configuration

### InfinumAzure

```ruby
# config/initializers/infinum_azure.rb

InfinumAzure.configure do |config|
  config.service_name = 'Revisor'
  config.resource_name = 'User'
  config.send_invite_request = !Rails.env.test? # to disable in tests
  config.resource_attributes = [:uid, :email, :name]
end
```

Configuration options:
* Service name - name of application
* Resource name - name of resource on whom authentication is being done
* Resource attributes - list of resource attributes that will be send to InfinumAzure when new user is created

### Secrets

Needed secrets:

```ruby
# config/secrets.yml

infinum_azure:
  client_id: 'client_id_from_InfinumAzure'
  client_secret: 'client_secret_from_InfinumAzure'
  tenant: 'InfinumAzure_tenant'
  name: 'InfinumAzure_name' # defaults to "azure" -> no need to change unless it's explicitly required
  policy: 'InfinumAzure_policy' # defaults to "B2C_1_sign_in" -> no need to change unless it's explicitly required
  scope: 'InfinumAzure_scope' # defaults to "openid" -> no need to change unless it's explicitly required
```

## Usage

1. Add columns to resource via migration.

    <b>Required columns:</b> email, uid and provider <br />
    <b>Optional columns:</b> name

2. Set same columns in resource attribute config of infinum_azure engine

3. Add following rows to resource model:

```ruby
devise :omniauthable, omniauth_providers: [:infinum_azure]
```

4. Create AuthenticatedController and inherit it in all controllers that needs to be protected with authentication

```ruby
class AuthenticatedController < ApplicationController
  before_action :authenticate_user!
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
