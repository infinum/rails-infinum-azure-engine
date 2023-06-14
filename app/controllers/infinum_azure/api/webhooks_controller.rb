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

        InfinumAzure::AfterUpsertResource.call(resource, user_params)

        render json: { resource_name.underscore => action }
      end

      private

      def resource
        @resource ||= resource_class.where(uid: user_params[:uid], provider: InfinumAzure.provider).or(
          resource_class.where(email: user_params[:email])
        ).first
      end

      def user_params
        InfinumAzure::Resources::Params
          .normalize(azure_params)
          .slice(*InfinumAzure.resource_attributes)
          .merge(provider: InfinumAzure.provider)
      end

      def azure_params
        params.require(:user).permit!.to_h.symbolize_keys
      end
    end
  end
end
