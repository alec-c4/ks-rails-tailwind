class LoginActivity < ApplicationRecord
  include IdentityCache::WithoutPrimaryIndex
  include Discard::Model

  belongs_to :user, polymorphic: true, optional: true

  encrypts :identity, deterministic: true
  encrypts :ip, deterministic: true

  cache_belongs_to :user

  default_scope { kept.order(created_at: :desc) }

  before_save :reduce_precision

  # reduce precision to city level to protect IP
  def reduce_precision
    self.latitude = latitude&.round(1) if try(:latitude_changed?)
    self.longitude = longitude&.round(1) if try(:longitude_changed?)
  end
end
