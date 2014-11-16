class UsersController < ApplicationController
  include TokenAuthenticateMe::Controllers::TokenAuthenticateable
  include ApiMe # Provides default api resource

  # Allow anyone to create a new user
  skip_before_action :authenticate, only: [:create]
end
