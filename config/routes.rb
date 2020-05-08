Rails.application.routes.draw do
  devise_for :users, skip: :saml_authenticatable, controllers: {
    registrations: 'user/registrations',
    sessions: 'user/sessions',
    passwords: 'user/passwords'
  }

  # opt-in saml_authenticatable
  devise_scope :user do
    scope 'users', controller: 'devise/saml_sessions' do
      get :destroy, path: 'sign_out', as: :destroy_user_sso_session
      match :idp_sign_out, path: 'saml/idp_sign_out', via: %i[get post]
    end

    get '/sp/saml/metadata',
        to: 'devise/saml_sessions#metadata',
        as: :new_sp_saml_metadata
    get '/sp/saml/private_resource',
        to: 'saml/decorated_saml_sessions#new',
        as: :new_sp_saml_resource
    post '/sp/saml/auth', to: 'saml/auth#create', as: :sp_saml_auth_session
  end

  root to: 'home#index'
end
