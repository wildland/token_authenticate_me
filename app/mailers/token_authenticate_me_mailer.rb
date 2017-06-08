class TokenAuthenticateMeMailer < ActionMailer::Base
  def valid_user_reset_password_email(root_url, user)
    @root_url = root_url
    @user = user
    @token_reset_path = token_reset_path(@user)

    mail(to: user.email, subject: 'Password Reset')
  end

  def invalid_user_reset_password_email(root_url, email)
    @root_url = root_url
    @email = email
    @signup_path = TokenAuthenticateMe.configuration.signup_path

    mail(to: email, subject: 'Password Reset Error')
  end

  def invite_user_email(root_url, invite)
    @root_url = root_url
    @email = invite.email
    @invite_path = invite_path(invite)

    mail(to: email, subject: 'Invitation To Join')
  end

  private

  def token_reset_path(user)
    TokenAuthenticateMe.configuration.reset_path.sub(/:token/, user.reset_password_token)
  end

  def invite_path(invite)
    TokenAuthenticateMe.configuration.invite_path.sub(/:id/, invite.to_s)
  end
end
