# spec/requests/users_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  # User signup test suite
  describe 'POST /signup' do
    context 'when valid request' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['message']).to match(/Account created successfully/)
      end

      it 'returns an authentication token' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'when invalid request' do
      before { post '/signup', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Name can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end

  describe 'GET /user' do
    context 'when valid request' do

      it 'returns user data' do
        post '/signup', params: valid_attributes.to_json, headers: headers
        auth_headers = {
          'Authorization': json["auth_token"],
          'Content-type': 'application/json'
        }
        get '/user', headers: auth_headers

        expect(response).to have_http_status(200)
        expect(json["name"]).to eq(valid_attributes[:name])
        expect(json["email"]).to eq(valid_attributes[:email])
      end
    end

    context 'when invalid request without token' do
      before { get '/user', params: {}, headers: headers }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message' do
        expect(json['message'])
          .to match(/Missing token/)
      end
    end
  end
end
