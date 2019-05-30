class Site
  include ActiveModel::AttributeAssignment
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps

  field :site_key, type: String
  field :region, type: String

  validates_uniqueness_of :site_key
  validates_presence_of :site_key
  validates_presence_of :region
end
