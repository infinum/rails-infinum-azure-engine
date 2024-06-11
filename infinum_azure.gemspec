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
  spec.required_ruby_version = '>= 3.0'

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

  spec.add_dependency 'bundler'
  spec.add_dependency 'devise'
  spec.add_dependency 'omniauth-infinum_azure', '>= 0.3.0', '< 2.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
