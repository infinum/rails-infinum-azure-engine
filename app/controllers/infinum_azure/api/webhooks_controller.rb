# frozen_string_literal: true

module InfinumAzure
  module Api
    class WebhooksController < Api::BaseController
      def upsert_resource_callback
        if resource
          resource.update(user_params)
          action = 'updated'
        else
          @resource = resource_class.create(user_params)
          action = 'created'
        end

        InfinumAzure::AfterUpsertResource.call(resource, normalized_azure_params)

        render json: { resource_name.underscore => action }
      end

      private

      def resource
        @resource ||= resource_class.where(uid: user_params[:uid], provider: InfinumAzure.provider).or(
          resource_class.where(email: user_params[:email])
        ).first
      end

      def user_params
        normalized_azure_params
          .slice(*InfinumAzure.config.resource_attributes)
          .merge(provider: InfinumAzure.provider)
      end

      def normalized_azure_params
        InfinumAzure::Resources::Params.normalize(
          params.require(:user).permit!.to_h.symbolize_keys
        )
      end
    end
  end
end
