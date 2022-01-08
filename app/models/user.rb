class User < ApplicationRecord
  include PgSearch::Model
  include Discard::Model
  include IdentityCache

  OAUTH_PROVIDERS = %w[google].freeze

  devise :database_authenticatable, :registerable,
    :confirmable, :lockable, :timeoutable, :trackable,
    :recoverable, :rememberable, :trackable, :validatable,
    :pwned_password, :omniauthable, omniauth_providers: OAUTH_PROVIDERS

  rolify
  has_subscriptions

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fit: [150, 150]
    attachable.variant :medium, resize_to_fit: [300, 300]
    attachable.variant :large, resize_to_fit: [500, 500]
  end

  enum gender: {
    male: "male",
    female: "female",
    other: "other",
    not_specified: "not_specified"
  }

  has_many :identities, dependent: :destroy
  belongs_to :banned_by, class_name: "User", optional: true
  has_many :login_activities, as: :user
  has_many :ahoy_visits, class_name: "Ahoy::Visit"
  has_many :ahoy_events, class_name: "Ahoy::Event"
  has_many :notifications, as: :recipient

  validates :first_name, presence: true, on: :update
  validates :last_name, presence: true, on: :update
  validates :time_zone, presence: true
  validate :check_name_format, on: :create
  validates :avatar, content_type: %w[image/png image/jpg image/jpeg]

  before_destroy :delete_avatar

  # discard
  after_discard do
    identities.discard_all
    login_activities.discard_all
    ahoy_visits.discard_all
    ahoy_events.discard_all
    notifications.discard_all
  end

  after_undiscard do
    identities.undiscard_all
    login_activities.undiscard_all
    ahoy_visits.undiscard_all
    ahoy_events.undiscard_all
    notifications.undiscard_all
  end

  ### Avatar
  def delete_avatar
    avatar&.purge_later
  end

  ### Search
  pg_search_scope :search,
    against: %i[first_name last_name email],
    using: {
      tsearch: {prefix: true},
      trigram: {}
    }

  # scopes
  default_scope { kept.order(created_at: :asc) }

  ### Ban
  def account_active?
    banned_at.nil?
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    # i18n-tasks-use t('devise.failure.banned')
    account_active? ? super : :banned
  end

  ### Name
  def name=(full_name)
    self.first_name, self.last_name = full_name.to_s.squish.split(/\s/, 2)
  end

  def name
    [first_name, last_name].join(" ")
  end

  def check_name_format
    errors.add(:name, I18n.t("activerecord.errors.messages.wrong_name_format")) unless name.match? /^\S+\s\S+$/
  end

  def to_s
    name
  end
end
