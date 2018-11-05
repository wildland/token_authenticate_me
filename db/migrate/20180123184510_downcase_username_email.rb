class DowncaseUsernameEmail < ActiveRecord::Migration[4.2]
  class TokenAuthenticateMe::User < ActiveRecord::Base
  end

  def change
    TokenAuthenticateMe::User.find_each do |user|
      user.username = user.username.downcase
      user.email = user.email.downcase
      user.save!(validate: false)
    end
  end
end
