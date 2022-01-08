class Identity < ApplicationRecord
  include Discard::Model
  include IdentityCache::WithoutPrimaryIndex

  default_scope { kept.order(created_at: :asc) }

  belongs_to :user

  cache_belongs_to :user

  validates :uid, :provider, presence: true
  validates :uid, uniqueness: {scope: :provider}
end
