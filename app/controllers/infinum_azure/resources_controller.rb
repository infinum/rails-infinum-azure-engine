# frozen_string_literal: true

module InfinumAzure
  class ResourcesController < InfinumAzure::ApplicationController
    def passthru
      render status: 404, plain: 'Not found. Logout passthru.'
    end

    def destroy
      sign_out current_resource

      redirect_to root_path
    end
  end
end
