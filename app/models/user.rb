class User < ApplicationRecord
  devise :saml_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
