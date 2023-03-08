# frozen_string_literal: true

require 'rails/generators/active_record'

module InfinumAzure
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __dir__)

      def inject_secrets
        insert_into_file 'config/secrets.yml', secrets_template,
                         after: "bugsnag_api_key: <%= Figaro.env.bugsnag_api_key! %>\n"
      end

      def copy_migration
        migration_template 'migration.rb', 'db/migrate/create_users.rb'
      end

      def copy_model
        template 'user.rb', 'app/models/user.rb'
      end

      def inject_routes
        insert_into_file 'config/routes.rb', routes_template,
                         after: "Rails.application.routes.draw do\n"
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def migration_version
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end

      private

      def routes_template
        <<RUBY
  devise_for :users, controllers: {
    omniauth_callbacks: 'infinum_azure/users/omniauth_callbacks'
  }
RUBY
      end

      def secrets_template
        <<RUBY
  infinum_azure:
    client_id: <%= Figaro.env.client_id %>
    client_secret: <%= Figaro.env.client_secret %>
    tenant: <%= Figaro.env.tenant %>
    name: <%= Figaro.env.name %>
    policy: <%= Figaro.env.policy %>
    scope: <%= Figaro.env.scope %>
RUBY
      end
    end
  end
end
