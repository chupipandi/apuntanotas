class Api::V1::AuthenticationController < Api::V1::BaseController
  require 'auth_token'

  skip_before_action :authenticate

  def register
    user = User.new(user_params)

    if user.save
      issue_token(user, :created)
    else
      render json: { errors: user.errors }, status: :bad_request
    end
  end

  def authenticate
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      issue_token(user)
    else
      render json:   { errors: 'Invalid email/password combination' },
             status: :unauthorized
    end
  end

  protected

  def user_params
    params.permit(:email, :username, :password, :password_confirmation)
  end

  def issue_token(user:, status: :ok)
    token = AuthToken.issue_token({ user_id: user.id })

    render json:   { user: UserSerializer.new(user), token: token },
           status: status
  end
end
