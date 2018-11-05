class AddIndexToUsers < ActiveRecord::Migration[4.2]
  def change
    add_index :token_authenticate_me_users, :password_digest, unique: true
  end
end
