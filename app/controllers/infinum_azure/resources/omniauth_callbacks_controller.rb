# frozen_string_literal: true

module InfinumAzure
  module Resources
    class OmniauthCallbacksController < Devise::OmniauthCallbacksController
      def infinum_azure
        resource = InfinumAzure::Resources::Finder.from_omniauth(omniauth)

        if resource
          flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Azure'
          sign_in_and_redirect resource, event: :authentication
        else
          flash[:notice] = 'You do not have permission to access this application.' # rubocop:disable Rails/I18nLocaleTexts
          redirect_to root_path
        end
      end

      def failure
        set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name),
                                             reason: failure_message
        redirect_to root_path
      end

      private

      def omniauth
        @omniauth ||= request.env['omniauth.auth']
      end
    end
  end
end
