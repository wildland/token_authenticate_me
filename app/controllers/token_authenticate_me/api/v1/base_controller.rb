module TokenAuthenticateMe
  module Api
    module V1
      class BaseController < TokenAuthenticateMe::ApplicationController
        skip_before_action :verify_authenticity_token
      end
    end
  end
end
