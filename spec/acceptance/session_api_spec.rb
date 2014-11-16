require 'spec_helper'

describe 'Session API' do
  it 'creates a new session when authenticating with a username and password' do
    password = "text"
    user = create_user(password: password)

    post '/session/',
        { username: user.username, password: password }

    expect(last_response.status).to eq(201)
    json = JSON.parse(last_response.body)

    expect(json["session"]).not_to be_nil
    expect(json["session"]["key"]).not_to be_nil
    expect(json["session"]["expiration"]).not_to be_nil
    expect(user.id).to eq(json["session"]["user_id"])
  end

  it 'creates a new session when authenticating with a email and password' do
    password = "text"
    user = create_user(password: password)

    post '/session/',
        { username: user.email, password: password }

    expect(last_response.status).to eq(201)
    json = JSON.parse(last_response.body)

    expect(json["session"]).not_to be_nil
    expect(json["session"]["key"]).not_to be_nil
    expect(json["session"]["expiration"]).not_to be_nil
    expect(user.id).to eq(json["session"]["user_id"])
  end

  it 'fails to create a new session when authenticating with an invalid password' do
    password = "text"
    user = create_user(password: password)

    post '/session/',
        { username: user.email, password: "not_test" }

    expect(last_response.status).to eq(401)
  end

  it 'fetches an existing session when authenticated' do
    password = "text"
    user = create_user(password: password)

    post '/session/',
        { username: user.email, password: password }
    expect(last_response.status).to eq(201)
    json = JSON.parse(last_response.body)

    header 'Authorization', 'Token token=' + json["session"]["key"]
    get '/session/'
    expect(last_response.status).to eq(200)

    json = JSON.parse(last_response.body)

    expect(json["session"]).not_to be_nil
    expect(json["session"]["key"]).not_to be_nil
    expect(json["session"]["expiration"]).not_to be_nil
    expect(user.id).to eq(json["session"]["user_id"])
  end

  it 'fetching an expired session fails' do
    user = create_user
    session = Session.create!(user_id: user.id)
    session.update!(expiration: 5.minutes.ago)

    header 'Authorization', 'Token token=' + session.key
    get '/session/'
    expect(last_response.status).to eq(401)
  end

  it 'destroying an existing session succeeds' do
    user = create_user
    session = Session.create!(user_id: user.id)

    header 'Authorization', 'Token token=' + session.key
    delete '/session/'
    expect(last_response.status).to eq(204)
  end

  it 'destroying an expired session fails' do
    user = create_user
    session = Session.create!(user_id: user.id)
    session.update!(expiration: 5.minutes.ago)

    header 'Authorization', 'Token token=' + session.key
    delete '/session/'
    expect(last_response.status).to eq(401)
  end
end
