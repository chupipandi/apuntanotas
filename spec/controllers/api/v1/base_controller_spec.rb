require 'rails_helper'
require 'jwt'

describe Api::V1::BaseController do
  describe '#authenticate' do
    controller(Api::V1::BaseController) do
      before_filter :authenticate

      def index
        render nothing: true
      end
    end

    let(:user) { create(:user) }

    before do
      @token = JWT.encode(
        { user_id: user.id },
        Rails.application.secrets[:secret_key_base]
      )
    end

    context 'when the credentials are valid' do
      it 'sets the current user' do
        request.headers['Authorization'] = "Bearer #{@token}"

        get :index

        expect(assigns(:current_user)).to eq(user)
      end
    end

    context 'when the credentials are not valid' do
      it 'renders an error' do
        response = get :index
        errors   = 'Authorization header not valid or expired'

        expect(response.body).to eq({ errors: errors }.to_json)
        expect(response.status).to eq(401)
      end
    end
  end
end
