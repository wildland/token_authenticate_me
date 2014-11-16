TokenAuthenticateMe
=====================

This gem adds simple API based token authentication. We at [inigo](http://inigo.io) wanted to be able to handle our entire authentication process -- including account creation and logging in -- through a RESTful API over JSON using token authentication, and found that solutions like Devise required too much hand holding due to its complexity to ultimately get the functionality that we wanted. Unfortunately we were unable to find a satisfactory existing solution -- though I'm sure one does exist, this isn't a new problem -- so we set out to create our own. After using internally on one project, we decided to roll it out into a gem to use on another.

## Getting started

Add the gem to your Gemfile:
`gem token_authenticate_me`

Run `bundle install` to install it.

To add or create a user with token authentication run:
`rails generate token_authenticate_me:install <model>`

Replace `<model>` with the class name used for users. This will create the necessary migration files, and optionally create the model file if it does not exist.
*** Right now this gem only supports creating the authentication model User, so it is recommended to call `rails generate token_authenticate_me:install user`

Include TokenAuthenticateMe::TokenAuthentication into the application controller or any controllers that require authorization:
````rb
require 'token_authenticate_me/token_authentication'

class ApplicationController < ActionController::Base
  force_ssl if Rails.env.production?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include TokenAuthenticateMe::TokenAuthentication

  #...
end
````

To skip authentication in a controller, just skip the authenticate before action:
````rb
class Api::V1::UsersController < Api::BaseController

  # Allow new users to create an account
  skip_before_action :authenticate, only: [:create]
end

### TODO:
  [ ] - Make it so any resource name can be used for authentication (initial thought is either specify the default or pass resource name in token string?).
