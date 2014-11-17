Rails.application.routes.draw do
  resource :session, only: [:create, :show, :destroy]

  resources :users

  resources(
    :password_resets,
    only: [:create, :update],
    constraints: {
      id: TokenAuthenticateMe::UUID_REGEX
    }
  )
end
