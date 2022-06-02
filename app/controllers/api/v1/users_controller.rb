class Api::V1::UsersController < ApplicationController

	before_action :require_login, only: [:update, :upload_avatar]

	def create
		@user = User.create_member(user_params)
		if @user.valid?
			@status = :created
			render_user_jwt
		else
			render_user_not_created
		end
	end

  def login
    @user = User.find_by(username: user_login_params[:username])
		password = user_login_params[:password]
    if @user && @user.authenticate(password: password)
			User.destroy_guest(current_user)
			render_user_jwt
    else
			render_invalid_username_or_password
    end
  end

	def index
		@users = User.members
		render_users
	end

	def show
		@user = User.find_by(slug: params[:user_slug])
		if @user
			render_user
		else
			render_user_not_found
		end
	end

	def current
		if current_user
			@user = current_user
			render_user
		else
			@user = User.create_guest
			render_user_jwt
		end
	end

	def upload_avatar
		user = current_user
		user.avatar_image = params[:avatar_image]
		user.save
	end

	private

	def status
		@status ||= :ok
	end

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

	def render_user
		@data = @user.json
		render_json
	end

	def render_user_jwt
		@data = @user.json
		@json = { jwt: encode_token({ user_id: @user.id }) }
		render_json
	end

	def render_users
		@data = User.json(users: @users)
		render_json
	end

	def render_user_not_created
		if @user.errors.full_messages.include?("Slug must be unique")
			@errors = { "register-username-input": "Username unavailable." }
			@status = :forbidden
		else
			@errors = { error: "User not created." }
			@status = :internal_server_error
		end
		render_json
	end

	def render_invalid_username_or_password
		@error = "Invalid username or password."
		@status = :unauthorized
		render_json
	end

	def render_user_not_found
		@errors = { slug: "User not found." }
		@status = :not_found
		render_json
	end

end
