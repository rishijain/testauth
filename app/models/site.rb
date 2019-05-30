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
  validate :valid_region

  private
  
  def valid_region
    regions = Settings.regions.keys
    flag = regions.any?{|a| a.to_sym == self.region.to_sym}
    errors.add(:invalid_region, "valid_regions should be #{regions}") unless flag
  end
end
