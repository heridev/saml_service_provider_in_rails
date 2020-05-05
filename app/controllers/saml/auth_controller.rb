module Saml
  class AuthController < Devise::SamlSessionsController
    # Here is where the Service Provider
    # can share specific resources with us
    def create
      response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])

      # In the case you support multiple providers
      # you can make this SamlSettings module dynamic
      # same as in the DecoratedSamlSessionsController#new method
      response.settings = SamlServiceProvider::SamlSettings.values

      if response.is_valid?
        respond_to do |format|
          puts '============== attributes sent by the Identity Provider ============================'
          puts response.attributes.attributes
          puts '============== attributes sent by the Identity Provider ============================'
          format.html { render plain: 'Authenticated resource message from the Service Provider' }
        end
      else
        respond_to do |format|
          format.html { render plain: 'invalid SAMLResponse' }
        end
      end
    end
  end
end

