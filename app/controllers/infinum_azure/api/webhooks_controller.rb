# frozen_string_literal: true

module InfinumAzure
  module Api
    class WebhooksController < Api::BaseController
      def upsert_resource_callback
        if resource
          resource.update(user_params)
          action = 'updated'
        else
          resource_class.create(user_params)
          action = 'created'
        end

        render json: { resource_name.underscore => action }
      end

      private

      def resource
        @resource ||= resource_class.where(uid: user_params[:uid], provider: InfinumAzure.provider).or(
          resource_class.where(email: user_params[:email])
        ).first
      end

      def user_params
        params.require(:user)
              .permit(InfinumAzure.resource_attributes)
              .merge(provider: InfinumAzure.provider)
      end
    end
  end
end
