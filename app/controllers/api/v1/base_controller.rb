class Api::V1::BaseController < ApplicationController
  require 'auth_token'

  before_action :authenticate

  protected

  def authenticate
    begin
      token           = request.headers['Authorization'].split.last
      payload, header = AuthToken.valid?(token)
      @current_user   = User.find(payload[:user_id]['$oid'])
    rescue
      render json: { errors: 'Authorization header not valid or expired' },
             status: :unauthorized
    end
  end
end
