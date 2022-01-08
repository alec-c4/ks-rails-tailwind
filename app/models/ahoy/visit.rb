class Ahoy::Visit < ApplicationRecord
  include IdentityCache::WithoutPrimaryIndex
  include Discard::Model

  self.table_name = "ahoy_visits"

  has_many :events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true

  cache_belongs_to :user

  default_scope { kept }
end
