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
end
```

Configuration options:
* Service name - name of application
* Resource name - name of resource on whom authentication is being done

### Secrets

Needed secrets:

```ruby
# config/secrets.yml

infinum_azure:
  client_id: 'client_id_from_InfinumAzure'
  client_secret: 'client_secret_from_InfinumAzure'
  tenant: 'InfinumAzure_tenant'
```

## Usage

1. Add columns to resource via migration.

    <b>Required columns:</b> email, uid and provider <br />
    <b>Optional columns:</b> name

2. Add following rows to resource model:

```ruby
devise :omniauthable, omniauth_providers: [:infinum_azure]
```

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
