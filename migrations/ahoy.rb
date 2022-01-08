class CreateAhoyVisitsAndEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :ahoy_visits, id: :uuid do |t|
      t.string :visit_token
      t.string :visitor_token

      # the rest are recommended but optional
      # simply remove any you don't want

      # user
      t.references :user, type: :uuid

      # standard
      t.string :ip
      t.text :user_agent
      t.text :referrer
      t.string :referring_domain
      t.text :landing_page

      # technology
      t.string :browser
      t.string :os
      t.string :device_type

      # location
      t.string :country
      t.string :region
      t.string :city
      t.float :latitude
      t.float :longitude

      # utm parameters
      t.string :utm_source
      t.string :utm_medium
      t.string :utm_term
      t.string :utm_content
      t.string :utm_campaign

      # native apps
      t.string :app_version
      t.string :os_version
      t.string :platform

      t.datetime :discarded_at
      t.datetime :started_at
    end

    add_index :ahoy_visits, :visit_token, unique: true
    add_index :ahoy_visits, :discarded_at

    create_table :ahoy_events, id: :uuid do |t|
      t.references :visit, type: :uuid
      t.references :user, type: :uuid

      t.string :name
      t.jsonb :properties
      t.datetime :time

      t.datetime :discarded_at
    end

    add_index :ahoy_events, [:name, :time]
    add_index :ahoy_events, :properties, using: :gin, opclass: :jsonb_path_ops
    add_index :ahoy_events, :discarded_at
  end
end
