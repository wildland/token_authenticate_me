TokenAuthenticateMe
=====================

This gem adds simple API based token authentication. We at [inigo](http://inigo.io) wanted to be able to handle our entire authentication process -- including account creation and logging in -- through a RESTful API over JSON using token authentication, and found that solutions like Devise required too much hand holding due to its complexity to ultimately get the functionality that we wanted. Unfortunately we were unable to find a satisfactory existing solution -- though I'm sure one does exist, this isn't a new problem -- so we set out to create our own. After using internally on one project, we decided to roll it out into a gem to use on another.

## Getting started

Add the gem to your Gemfile:
`gem token_authenticate_me`

Run `bundle install` to install it.

To install run the following:
`rails generate token_authenticate_me:install`

Include TokenAuthenticateMe::TokenAuthenticateable into the application controller or any controllers that require authorization:
````rb
require 'token_authenticate_me/concerns/controllers/token_authenticateable'

class ApplicationController < ActionController::Base
  include TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include TokenAuthenticateMe::Controllers::TokenAuthenticateable

  #...
end
````

To skip authentication in a controller, just skip the authenticate before action:
````rb
class Api::V1::UsersController < Api::BaseController

  # Allow new users to create an account
  skip_before_action :authenticate, only: [:create]
end
````

## Authentication Model
The model has 3 concerns:
* [Authenticatable](https://github.com/wildland/token_authenticate_me/blob/master/lib/token_authenticate_me/concerns/models/authenticatable.rb)
* [Invitable](https://github.com/wildland/token_authenticate_me/blob/master/lib/token_authenticate_me/concerns/models/invitable.rb)
* [Sessionable](https://github.com/wildland/token_authenticate_me/blob/master/lib/token_authenticate_me/concerns/models/sessionable.rb)

*tl;dr*:
* `email` is required, can't be blank, is unique (case insensitive), and must look like an email address.
* `password` is required, can not be blank, it must be confirmed (`password_confirmation`), and must be between 8 and 72 characters long. If the model has been persisted `password` can be blank or `nil` which indicates that it should not be changed and will be ignored.
* `username` is required, can't be blank, is unique (case insensitive), and only allows alphanumeric values.
* To change the `password` or `email` after the model has been persisted, you will need to provide the current password as `current_password`.

## Code Of Conduct
Wildland Open Source [Code Of Conduct](https://github.com/wildland/code-of-conduct)
