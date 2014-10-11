require 'rails_helper'

describe Api::V1::AuthenticationController do
  describe 'POST #register' do
    context 'with correct input' do
      it 'returns the user and token' do
        user     = attributes_for(:user)
        response = post :register, user, format: :json

        pattern = {
          user: {
            id:       wildcard_matcher,
            email:    user[:email],
            username: user[:username]
          },
          token: wildcard_matcher
        }

        expect(response.body).to match_json_expression(pattern)
        expect(response.status).to eq(201)
      end
    end

    context 'with invalid input' do
      it 'returns an errors message' do
        user_attrs = attributes_for(:user, email: nil, username: nil)
        response   = post :register, user_attrs, format: :json
        user       = User.create(user_attrs)

        expect(response.body).to eq({ errors: user.errors.messages }.to_json)
        expect(response.status).to eq(400)
      end
    end
  end

  describe 'POST #authenticate' do
    context 'with correct input' do
      it 'returns the user and token' do
        user     = create(:user)
        response = post :authenticate,
                        { email: user.email, password: user.password },
                        format: :json

        pattern = {
          user: {
            id:       wildcard_matcher,
            email:    user[:email],
            username: user[:username]
          },
          token: wildcard_matcher
        }

        expect(response.body).to match_json_expression(pattern)
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid input' do
      it 'returns an error message' do
        response = post :authenticate,
                   { email: '', password: '' },
                   format: :json

        errors = { errors: 'Invalid email/password combination' }

        expect(response.body).to eq(errors.to_json)
        expect(response.status).to eq(401)
      end
    end
  end
end
