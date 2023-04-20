# frozen_string_literal: true

module TestHelpers
  module HttpRequest
    def default_headers
      { 'Content-Type': 'application/json' }
    end
  end
end
