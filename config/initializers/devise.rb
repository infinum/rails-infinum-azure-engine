Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.sign_out_via = :get

  # ==> OmniAuth
  config.omniauth :infinum_azure, InfinumAzure.client_id, InfinumAzure.client_secret,
                  client_options: { tenant: InfinumAzure.tenant }
end
