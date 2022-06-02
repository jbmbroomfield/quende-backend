class Api::V1::UsersController < ApplicationController

	before_action :require_login, only: [:update, :upload_avatar]

	def create
		@user = User.create_member(user_params)
		@user.valid? ? user_created : user_not_created
	end

  def login
    @user = User.find_by(username: user_login_params[:username])
		password = user_login_params[:password]
    if @user && @user.authenticate(password: password)
			user_logged_in
    else
			invalid_username_or_password
    end
  end

	def index
		@users = User.members
		users
	end

	def show
		@user = User.find_by(slug: params[:user_slug])
		@user ? user : user_not_found
	end

	def current
		current_user ? user_current : create_guest
	end

	def upload_avatar
		@user = current_user
		@user.avatar_image = params[:avatar_image]
		@user.save
		user
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

	def user
		@data = @user.json
	end

	def user_jwt
		@data = @user.json
		@jwt = encode_token({ user_id: @user.id })
	end

	def user_created
		@status = :created
		user_jwt
	end

	def user_logged_in
		User.destroy_guest(current_user)
		user_jwt
	end

	def user_current
		@user = current_user
		user
	end

	def create_guest
		@user = User.create_guest
		user_jwt
	end

	def users
		@data = User.json(users: @users)
	end

	def user_not_created
		if @user.errors.full_messages.include?("Slug must be unique")
			@errors = { "register-username-input": "Username unavailable." }
			@status = :forbidden
		else
			@errors = { error: "User not created." }
			@status = :internal_server_error
		end
	end

	def invalid_username_or_password
		@error = "Invalid username or password."
		@status = :unauthorized
	end

	def user_not_found
		@errors = { slug: "User not found." }
		@status = :not_found
	end

end
