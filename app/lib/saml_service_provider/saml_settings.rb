module SamlServiceProvider
  module SamlSettings
    class << self
      def values
        saml_settings = OneLogin::RubySaml::Settings.new
        # you current service provider url to authenticate your SAMLResponse
        # from the Identity Provider
        saml_settings.assertion_consumer_service_url = ENV['ASSERTION_CONSUMER_SERVICE_URL']
        saml_settings.protocol_binding = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'
        saml_settings.name_identifier_format = 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient'

        # Service provider that generates the SAMLRequest
        saml_settings.issuer = ENV['ISSUER']
        saml_settings.authn_context = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'
        # In the case that you need to also log-out the user from the Identity provider
        # here is a good place to do so
        saml_settings.idp_slo_target_url = ''

        # Identity provider information
        saml_settings.idp_sso_target_url = ENV['IDP_SSO_TARGET_URL']
        saml_settings.idp_cert_fingerprint = ENV['IDP_CERT_FINGERPRINT']
        saml_settings.idp_cert_fingerprint_algorithm = 'http://www.w3.org/2000/09/xmldsig#sha256'
        saml_settings
      end
    end
  end
end
