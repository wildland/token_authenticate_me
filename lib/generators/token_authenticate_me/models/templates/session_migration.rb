class UserMigration < ActiveRecord::Migration
  def up
    create_table :sessions do |t|
      t.string   :key,        null: false
      t.datetime :expiration
      t.integer  :user_id
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_index :key, unique: true
  end

  def down
    drop_table :sessions
  end
end
