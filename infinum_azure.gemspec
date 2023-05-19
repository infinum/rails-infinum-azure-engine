# frozen_string_literal: true

require_relative 'lib/infinum_azure/version'

Gem::Specification.new do |spec|
  spec.name = 'infinum_azure'
  spec.version = InfinumAzure::VERSION
  spec.authors = ['Marko Ćilimković']
  spec.email = ['marko.cilimkovic@infinum.hr']

  spec.summary = 'Authentication mechanism for Rails apps with devise via OAuth2'
  spec.homepage = 'https://github.com/infinum/rails-infinum-azure-engine'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/infinum/rails-infinum-azure-engine'
  spec.metadata['changelog_uri'] = 'https://github.com/infinum/rails-infinum-azure-engine/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'rails', '~> 7.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'bundler'
  spec.add_dependency 'devise'
  spec.add_dependency 'omniauth-infinum_azure', '>= 0.1.6', '< 2.0'
end
