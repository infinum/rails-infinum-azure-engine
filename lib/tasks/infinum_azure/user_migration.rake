# frozen_string_literal: true

require_relative 'users/request'
require_relative 'users/migration'

namespace :infinum_azure do
  desc 'Migrate users from InfinumID to InfinumAzure'
  task migrate_users: :environment do
    response = InfinumAzure::Users::Request.execute

    if response.success?
      process = InfinumAzure::Users::Migration.perform(response.body)

      puts process.results
    else
      puts response.body
      raise "couldn't connect to InfinumAzure AD B2C"
    end
  end
end
