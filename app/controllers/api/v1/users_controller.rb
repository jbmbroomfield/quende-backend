class Api::V1::UsersController < ApplicationController

	before_action :require_login, only: [:update, :upload_avatar]

	def create
		user = User.create(username: user_params[:username])
		if user.valid?
			user.email_address = user_params[:email_address]
			user.password = user_params[:password]
			@token = encode_token(user_id: user.id)
			render json: UserSerializer.new(user), status: :created
		else
			# user.destroy_dependents
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
	end

  def login
    user = User.find_by(username: user_login_params[:username])
		password = user_login_params[:password]
    if user && user.authenticate(password: password)
      if current_user && current_user.guest
        current_user.destroy
      end
			token = encode_token({ user_id: user.id })
	    render json: { user: UserSerializer.new(user), jwt: token }, status: :ok
    else
      render json: {
        errors: {
          error: 'Invalid username or password.'
        }
      }, status: :unauthorized
    end
  end

	def index
		render_all
	end

	def show
		user = User.find_by(slug: params[:user_slug])
		render_object(user)
	end

	def current
		if current_user
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

end
