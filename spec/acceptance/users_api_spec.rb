require 'spec_helper'

describe 'Users API' do
  it 'creates a new user when unauthenticated' do
    username = 'test'
    password = 'test'
    email = 'test'

    post '/users/',
         user: {
           username: username,
           password: password,
           password_confirmation: password,
           email: email
         }

    expect(last_response.status).to eq(201)
    json = JSON.parse(last_response.body)

    expect(json['user']).not_to be_nil
    expect(json['user']['username']).to eq(username)
    expect(json['user']['email']).to eq(email)
  end

  it 'fails to create a new user when the password confirmation does not match' do
    username = 'test'
    password = 'test'
    email = 'test'

    post '/users/',
         user: {
           username: username,
           password: password,
           password_confirmation: 'invalid',
           email: email
         }

    expect(last_response.status).to eq(422)
  end

  it 'succeeds to list users when authenticated' do
    user = create_user
    session = Session.create!(user_id: user.id)

    header 'Authorization', 'Token token=' + session.key
    get '/users/'

    expect(last_response.status).to eq(200)
  end

  it 'fails to list users without being authenticated' do
    get '/users/'

    expect(last_response.status).to eq(401)
  end

  it 'does not serialze password digest' do
    user = create_user
    session = Session.create!(user_id: user.id)

    header 'Authorization', 'Token token=' + session.key
    get '/users/' + user.id.to_s + '/'

    expect(last_response.status).to eq(200)
    json = JSON.parse(last_response.body)

    expect(json['user']).not_to be_nil
    expect(json['user']['password_digest']).to be_nil
  end
end
