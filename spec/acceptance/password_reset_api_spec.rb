require 'spec_helper'

describe 'Password Reset API' do
  it 'resets the users password when called with the correct token' do
    user = create_user

    user.create_reset_token!
    encrypted_pw = user.password_digest
    reset_token = user.reset_password_token.to_s

    put '/password_resets/' + reset_token + '/',
        password: 'test', password_confirmation: 'test'

    expect(last_response.status).to eq(204)
    expect(User.find(user.id).password_digest).not_to eq(encrypted_pw)
  end

  it 'does not allow replay attacks' do
    user = create_user

    user.create_reset_token!
    encrypted_pw = user.password_digest
    reset_token = user.reset_password_token.to_s

    put '/password_resets/' + reset_token + '/',
        password: 'test', password_confirmation: 'test'

    expect(last_response.status).to eq(204)
    expect(User.find(user.id).password_digest).not_to eq(encrypted_pw)

    put '/password_resets/' + reset_token + '/',
        password: 'test', password_confirmation: 'test'
    expect(last_response.status).to eq(404)
  end

  it 'fails to reset the users password when the confirmation does not match' do
    user = create_user

    user.create_reset_token!
    encrypted_pw = user.password_digest
    reset_token = user.reset_password_token.to_s

    put '/password_resets/' + reset_token + '/',
        password: 'test', password_confirmation: 'test_ops'

    expect(last_response.status).to eq(422)
    expect(User.find(user.id).password_digest).to eq(encrypted_pw)
  end

  it 'raises a routing error when called with an empty token' do
    user = create_user

    user.create_reset_token!
    encrypted_pw = user.password_digest

    expect do
      put '/password_resets//',  password: 'test', password_confirmation: 'test'
    end.to raise_error(ActionController::RoutingError)
    expect(User.find(user.id).password_digest).to eq(encrypted_pw)
  end

  it 'returns a 404 when reset is requested with a bad token' do
    user = create_user

    user.create_reset_token!

    put '/password_resets/' + SecureRandom.hex.to_s + '/',
        password: 'test', password_confirmation: 'test'

    expect(last_response.status).to eq(404)
  end

  it 'returns a 204 when a password reset is requested with a valid e-mail' do
    user = create_user

    post '/password_resets/',  email: user.email

    expect(last_response.status).to eq(204)
  end

  it 'returns a 204 when a password reset is requested with a invalid e-mail' do
    user = create_user # rubocop:disable Lint/UselessAssignment

    post '/password_resets/',  email: 'foo@bar.com'

    expect(last_response.status).to eq(204)
  end

  it 'sends a valid e-mail when a password reset is requested with a valid e-mail' do
    user = create_user

    post '/password_resets/',  email: user.email

    mail = ActionMailer::Base.deliveries.last

    expect(mail['to'].to_s).to eq(user.email)
    expect(mail['subject'].to_s).to eq('Password Reset')
  end

  it 'sends a invalid e-mail when a password reset is requested with a invalid e-mail' do
    user = create_user # rubocop:disable Lint/UselessAssignment
    email = 'foo@bar.com'

    post '/password_resets/',  email: email

    mail = ActionMailer::Base.deliveries.last

    expect(mail['to'].to_s).to eq(email)
    expect(mail['subject'].to_s).to eq('Password Reset Error')
  end
end
