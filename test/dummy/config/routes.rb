Rails.application.routes.draw do
  mount TokenAuthenticateMe::Engine => '/token_authenticate_me'
end
