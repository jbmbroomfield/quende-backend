class Api::V1::UsersController < ApplicationController

	before_action :require_login, only: [:update, :upload_avatar]

	def create
		user = User.create_member(user_params)
		if user.valid?
			render json: UserSerializer.new(user), status: :created
		else
			render_user_not_created(user)
		end
	end

  def login
    user = User.find_by(username: user_login_params[:username])
		password = user_login_params[:password]
    if user && user.authenticate(password: password)
			User.destroy_guest(current_user)
			token = encode_token({ user_id: user.id })
	    render json: { user: UserSerializer.new(user), jwt: token }, status: :ok
    else
			render_invalid_username_or_password
    end
  end

	def index
		render json: UserSerializer.new(User.members), status: :ok
	end

	def show
		user = User.find_by(slug: params[:user_slug])
		if user
			render json: UserSerializer.new(user), status: :ok
		else
			render_user_not_found
		end
	end

	def current
		if current_user
			token = encode_token({ user_id: current_user.id })
	    render json: { user: UserSerializer.new(current_user), jwt: token }, status: :ok
		else
			user = User.create_guest
			token = encode_token({ user_id: user.id })
			render json: { user: UserSerializer.new(user), jwt: token }, status: :ok
		end
	end

	def upload_avatar
		user = current_user
		user.avatar_image = params[:avatar_image]
		user.save
	end

	private

	def user_params
		params.require(:user).permit(
			:username,
			:email_address,
			:password,
		)
	end

  def user_login_params
    params.require(:user).permit(
      :username,
      :password,
    )
	end

	def render_user_not_created(user)
		if user.errors.full_messages.include?("Slug must be unique")
			render json: {
				errors: {
					username: "Username unavailable."
				}
			}, status: :forbidden
		else
			render json: {
				message: "User not created."
			}, status: :internal_server_error
		end
	end

	def render_invalid_username_or_password
		render json: {
			errors: {
				error: 'Invalid username or password.'
			}
		}, status: :unauthorized
	end

	def render_user_not_found
		render json: {
			errors: {
				slug: "User not found."
			}
		}, status: :not_found
	end

end
