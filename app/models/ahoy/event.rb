class Ahoy::Event < ApplicationRecord
  include Ahoy::QueryMethods
  include IdentityCache::WithoutPrimaryIndex
  include Discard::Model

  self.table_name = "ahoy_events"

  belongs_to :visit
  belongs_to :user, optional: true

  cache_belongs_to :user

  default_scope { kept }
end
