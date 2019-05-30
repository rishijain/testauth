class User
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword
  include Mongoid::Timestamps

  field :email
  field :password
  field :password_digest
  field :activated_at, type: DateTime
  field :regions, type: Hash

  has_secure_password

  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :regions
  validates_presence_of :password_digest
  validate :validate_regions
  validate :validate_ref_user_presence
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  private

  def validate_regions
    regions = Settings.regions.keys
    return unless self.regions
    flag = self.regions.keys.all?{|a| regions.include?(a.to_sym)}
    errors.add(:invalid_region, "valid_regions should be #{regions}") unless flag
  end

  def validate_ref_user_presence
    return unless self.regions
    flag = self.regions.any?{|k,v| v[:ref_user_id]}
    errors.add(:MissingRefUserId, "ref_user_id should be present." ) unless flag
  end
end
