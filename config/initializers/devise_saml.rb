# devise saml configuration
Devise.setup do |config|
  config.saml_create_user = false
  config.saml_update_user = true
  config.saml_default_user_key = :email
  config.saml_session_index_key = :session_index
  config.saml_use_subject = true
  config.idp_settings_adapter = nil
end
