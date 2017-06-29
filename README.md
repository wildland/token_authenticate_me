TokenAuthenticateMe
=====================

This gem adds simple API based token authentication. We at [inigo](http://inigo.io) wanted to be able to handle our entire authentication process -- including account creation and logging in -- through a RESTful API over JSON using token authentication, and found that solutions like Devise required too much hand holding due to its complexity to ultimately get the functionality that we wanted. Unfortunately we were unable to find a satisfactory existing solution -- though I'm sure one does exist, this isn't a new problem -- so we set out to create our own. After using internally on one project, we decided to roll it out into a gem to use on another.

## Upgrade Instructions
  - For all major and minor run: `rails generate token_authenticate_me:install`
  - Note: Patch version upgrades shouldnt need to run the install command.

## Getting Started

Add the gem to your Gemfile:
`gem token_authenticate_me`

Run `bundle install` to install it.

To install run the following:
`rails generate token_authenticate_me:install`

Include `TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable` into api controllers that require authorization:
````rb
require 'token_authenticate_me/concerns/controllers/token_authenticateable'

class ApiController < ApplicationController
  include TokenAuthenticateMe::Concerns::Controllers::TokenAuthenticateable

  skip_before_filter :verify_authenticity_token # CSRF is not needed for header or param based auth

  #...
end
````

Include `TokenAuthenticateMe::Concerns::Controllers::SessionAuthenticateable` into server rendered page controllers that require authorization:
````rb
require 'token_authenticate_me/concerns/controllers/session_authenticateable'

class AuthenticatedController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  include TokenAuthenticateMe::Concerns::Controllers::SessionAuthenticateable

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
