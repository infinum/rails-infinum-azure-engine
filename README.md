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
  config.resource_attributes = [:uid, :email, :first_name, :last_name]
end
```

Configuration options:
* Service name - name of application
* Resource name - name of resource on whom authentication is being done
* Resource attributes - attributes sent from InfinumAzure when user is created/updated that will be permitted

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

## Migration from Infinum ID (WIP - don't start the process yet)

The migration needs to be done in steps:

0. Substitute the `infinum_id` gem with this one, and deploy. Ensure the version is set to 0.1.0! Announce to anyone that's heavily using the app that logging in will be down for a few minutes. Continue to step 1.

1. Since we're switching from Infinum ID to Azure identity provider, the `provider` and the `uid` attributes for each user will change. We need to use the `email` as a primary identifier. The problem is that Infinum also changed the primary domain from `@infinum.hr` to `@infinum.com`. So the first step is to update all user emails to have `@infinum.com` domain. Ensure the following code is successful:

```ruby
User.all.group_by { |u| u.email.split('@').last }.select { |domain, users| domain != 'infinum.com' }.each { |domain, users| users.each { |u| u.update_attribute(:email, u.email.gsub(domain, 'infinum.com')) } }
```

Logging in will be working again now. Test it and inform users. Continue to step 2.

2. The next step will be to run the rake task `infinum_azure:migrate_users`, which will use the Azure API endpoint and update all user `uid` attributes to the Azure uid value, and the `provider` value to "infinum_azure". This rake task can be executed multiple times. The goal is for all users to have the `provider` set to "infinum_azure". We depend on the user migration from Infinum ID to Infinum Azure, so some users might still be missing. If you have users that aren't migrated, report to Slack #product-infinum-auth channel.

3. The last step is to bump to a new version of `infinum_azure` (will probably be 1.0.0), which will stop using the `email` as the unique identifier for logging in, and go back to using the `provider` and `uid`.

4. The subsequent versions will also have to contain the webhook API endpoints that will update user records when a change happens on Infinum Azure. (TBD)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
