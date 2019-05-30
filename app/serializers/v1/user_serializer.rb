class V1::UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :regions
end
