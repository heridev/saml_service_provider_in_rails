module SamlServiceProvider
  module SamlSettings
    class << self
      def values
        saml_settings = OneLogin::RubySaml::Settings.new
        # you current service provider url to authenticate your SAMLResponse
        # from the Identity Provider
        acs_url = ENV['ASSERTION_CONSUMER_SERVICE_URL'] || 'https://localhost:3030/sp/saml/auth'
        saml_settings.assertion_consumer_service_url = acs_url
        saml_settings.protocol_binding = 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST'
        saml_settings.name_identifier_format = 'urn:oasis:names:tc:SAML:2.0:nameid-format:transient'

        # Service provider that generates the SAMLRequest
        saml_settings.issuer = ENV['ISSUER'] || 'https://localhost:3030/sp/saml/metadata'
        saml_settings.authn_context = 'urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport'
        # In the case that you need to also log-out the user from the Identity provider
        # here is a good place to do so
        saml_settings.idp_slo_target_url = ''

        # Identity provider information
        idp_sso_url = ENV['IDP_SSO_TARGET_URL'] || 'https://localhost:3000/idp/saml/auth'
        saml_settings.idp_sso_target_url = idp_sso_url
        idp_fingerprint = ENV['IDP_CERT_FINGERPRINT'] || 'E4:FC:60:40:03:A2:33:9D:AA:9D:50:59:F2:04:F0:3C:88:62:3B:F1:EB:D8:4C:FF:9C:D1:93:07:03:F7:C9:74'
        saml_settings.idp_cert_fingerprint = idp_fingerprint
        saml_settings.idp_cert_fingerprint_algorithm = 'http://www.w3.org/2000/09/xmldsig#sha256'
        saml_settings
      end
    end
  end
end
