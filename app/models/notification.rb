class Notification < ApplicationRecord
  include Noticed::Model
  include Discard::Model

  belongs_to :recipient, polymorphic: true
end
