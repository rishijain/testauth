class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword
  include Mongoid::Timestamps

  field :email
  field :password
  field :password_digest
  field :activated_at, type: DateTime
  has_secure_password
end
