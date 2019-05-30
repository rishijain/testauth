class Site
  include ActiveModel::AttributeAssignment
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps
  validates_uniqueness_of :site_key
end
