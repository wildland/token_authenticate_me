module Fixtures
  module Users
    def create_user(username: 'test', email: 'test@email.com', password: 'password')
      User.create!(
        username: username,
        email: email,
        password: password
      )
    end
  end
end
