module Saml
  class DecoratedSamlSessionsController < Devise::SamlSessionsController
    def new
      request = OneLogin::RubySaml::Authrequest.new
      auth_params = { RelayState: relay_state } if relay_state

      # In the case you support multiple providers
      # you can make this SamlSettings module dynamic
      # same as in the Saml::AuthController#create method
      saml_config = SamlServiceProvider::SamlSettings.values

      action = request.create(saml_config, auth_params || {})
      redirect_to action
    end
  end
end

