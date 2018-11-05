class CreateTokenAuthenticateMeUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :token_authenticate_me_users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :reset_password_token
      t.datetime :reset_password_token_exp

      t.timestamps null: false
    end

    add_index :token_authenticate_me_users, :email,                unique: true
    add_index :token_authenticate_me_users, :username,             unique: true
    add_index :token_authenticate_me_users, :reset_password_token, unique: true
    add_foreign_key :token_authenticate_me_invites, :token_authenticate_me_users, column: :creator_id
  end
end
