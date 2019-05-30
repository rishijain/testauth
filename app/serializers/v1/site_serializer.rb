class V1::SiteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :site_key, :region
end
