class CreateIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :identities, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.string :provider, null: false, default: ""
      t.string :uid, null: false, default: ""

      t.datetime :discarded_at
      t.timestamps
    end

    add_index :identities, %i[uid provider], unique: true
    add_index :identities, :discarded_at
  end
end
