module Saml
  class AuthController < Devise::SamlSessionsController
    # Here is where the Service Provider
    # can share specific resources with us
    def create
      saml_response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])

      # In the case you support multiple providers
      # you can make this SamlSettings module dynamic
      # same as in the DecoratedSamlSessionsController#new method
      saml_response.settings = SamlServiceProvider::SamlSettings.values

      if saml_response.is_valid?
        respond_to do |format|
          puts '============== attributes sent by the Identity Provider ============================'
          puts saml_response.attributes.attributes
          puts "page_name from params #{params[:page_name]}"
          puts '============== attributes sent by the Identity Provider ============================'
          format.html { render :create, layout: 'widgets' }
        end
      else
        respond_to do |format|
          format.html { render plain: 'invalid SAMLResponse' }
        end
      end
    end
  end
end

