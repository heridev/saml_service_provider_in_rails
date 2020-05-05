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
      get :metadata, path: 'saml/metadata', as: :metadata_user_sso_session
      match :idp_sign_out, path: 'saml/idp_sign_out', via: %i[get post]
    end

    get '/users/saml/sign_in', to: 'saml/decorated_saml_sessions#new', as: :new_user_sso_session
    post '/users/saml/auth', to: 'saml/auth#create', as: :user_sso_session
  end
end
