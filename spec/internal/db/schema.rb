ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :username, null: false
    t.string :email, null: false
    t.string :password_digest, null: false
    t.string :reset_password_token
    t.datetime :reset_password_token_exp

    t.timestamps
  end

  create_table :sessions, force: true do |t|
    t.string :key,        null: false
    t.datetime :expiration
    t.integer :user_id

    t.timestamps
  end
end
