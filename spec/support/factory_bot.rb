# frozen_string_literal: true

require 'pathname'

FactoryBot.definition_file_paths = [Pathname.new(File.expand_path('../factories', __dir__))]
