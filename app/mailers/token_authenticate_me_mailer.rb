class TokenAuthenticateMeMailer < ActionMailer::Base
  SIGNUP_PATH = 'sign-up'
  RESET_PATH = 'reset-password/:token/'

  helper :application

  def valid_user_reset_password_email(root_url, user)
    @root_url = root_url
    @user = user
    @reset_path = RESET_PATH

    @token_reset_path = token_reset_path

    mail(to: user.email, subject: 'Password Reset')
  end

  def invalid_user_reset_password_email(root_url, email)
    @root_url = root_url
    @email = email
    @signup_path = SIGNUP_PATH

    mail(to: email, subject: 'Password Reset Error')
  end

  private

  def token_reset_path
    @reset_path.sub(/:token/, @user.reset_token)
  end
end
