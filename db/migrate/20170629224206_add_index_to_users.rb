class AddIndexToUsers < ActiveRecord::Migration
  def change
    add_index :token_authenticate_me_users, :password_digest, unique: true
  end
end
