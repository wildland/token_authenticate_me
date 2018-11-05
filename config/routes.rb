TokenAuthenticateMe::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
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
  end
end
