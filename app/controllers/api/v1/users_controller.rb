class Api::V1::UsersController < ApplicationController

	before_action :require_login, only: [:update, :upload_avatar]

	def create
		user = User.create_member(user_params)
		if user.valid?
			render_user_jwt(user, :created)
		else
			render_user_not_created(user)
		end
	end

  def login
    user = User.find_by(username: user_login_params[:username])
		password = user_login_params[:password]
    if user && user.authenticate(password: password)
			User.destroy_guest(current_user)
			render_user_jwt(user)
    else
			render_invalid_username_or_password
    end
  end

	def index
		render_users(User.members)
	end

	def show
		user = User.find_by(slug: params[:user_slug])
		if user
			render_user(user)
		else
			render_user_not_found
		end
	end

	def current
		if current_user
			render_user(current_user)
		else
			render_user_jwt(User.create_guest)
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

	def render_user(user, status=:ok)
		render json: { success: true, data: user.json }, status: status
	end

	def render_user_jwt(user, status=:ok)
		jwt = encode_token({ user_id: user.id })
		render json: { success: true, data: user.json, jwt: jwt}, status: status
	end

	def render_users(users, status=:ok)
		render json: { success: true, data: User.json(users) }, status: status
	end

	def render_user_not_created(user)
		if user.errors.full_messages.include?("Slug must be unique")
			render json: {
				errors: {
					"register-username-input": "Username unavailable."
				}
			}, status: :forbidden
		else
			render json: {
				errors: {
					error: "User not created."
				}
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
