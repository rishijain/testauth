class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword


  field :email
  field :password
  field :password_digest

  has_secure_password
end
