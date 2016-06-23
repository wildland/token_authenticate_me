class CreateTokenAuthenticateMeSessions < ActiveRecord::Migration
  def change
    create_table :token_authenticate_me_sessions do |t|
      t.string   :key,        null: false
      t.datetime :expiration
      t.integer  :user_id

      t.timestamps null: false
    end

    add_index :token_authenticate_me_sessions, :key, unique: true
  end
end
