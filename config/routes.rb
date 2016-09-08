TokenAuthenticateMe::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :session, only: [:create, :show, :destroy]
      resources :users

      resources :invites, except: [:update] do
        member do
          get 'accept'
          get 'decline'
        end
      end

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
