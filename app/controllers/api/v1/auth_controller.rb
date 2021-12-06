class Api::V1::AuthController < ApplicationController

  def create
    user = User.find_by(username: user_login_params[:username])
    if user && user.password_authenticate(user_login_params[:password_authentication_attributes][:password])
      if current_user && current_user.account_level == 'guest'
        current_user.destroy
      end
      render_user(user)
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def guest_login
    if !current_user || current_user.account_level != 'guest'
      user = User.create(account_level: 'guest')
    else
      user = current_user
    end
    token = encode_token({ user_id: user.id })
    render json: { user: UserSerializer.new(user), jwt: token }, status: :accepted
  end

  private

  def render_user(user)
    token = encode_token({ user_id: user.id })
    render json: { user: UserSerializer.new(user), jwt: token }, status: :accepted
  end

  def user_login_params
    params.require(:user).permit(
      :username,
      password_authentication_attributes: [
        :password,
      ]
    )
  end

end
