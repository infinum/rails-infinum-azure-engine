# frozen_string_literal: true

module InfinumAzure
  class ResourcesController < InfinumAzure::ApplicationController
    def destroy
      sign_out current_resource

      redirect_to root_path
    end
  end
end
