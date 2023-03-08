# frozen_string_literal: true

module InfinumAzure
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
