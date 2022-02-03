class Api::V1::UsersController < ApplicationController

	before_action :require_login, only: [:update, :upload_avatar]

	def create
		password = user_params[:password_authentication_attributes][:password]
		password_confirmation = user_params[:password_authentication_attributes][:password_confirmation]
		
		if password != password_confirmation
			render json: {
				errors: {
					password: "",
					password_confirmation: "Passwords do not match."
				}
			}, status: :not_acceptable
			return
		end

		slug = user_params[:username].gsub(/_/, '-').parameterize
		slug_users = User.where(slug: slug)
		if slug_users.count > 0
			render json: {
				errors: {
					username: "Username unavailable."
				}
			}, status: :not_acceptable
			return
		end

		user = User.create(user_params)
		if user.valid?
			@token = encode_token(user_id: user.id)
			render_json(user, status: :created)
		else
			failed_to_create(user)
		end
	end

	def index
		render_all
	end

	def show
		user = User.find_by(slug: params[:user_slug])
		render_object(user)
	end

	def update
		user = current_user
		user.update(user_update_params)
		render_object(user)
	end

	def current
		if current_user
			render_json(current_user)
		else
			user = User.create(account_level: 'guest')
			token = encode_token({ user_id: user.id })
			render json: { user: UserSerializer.new(user), jwt: token }, status: :accepted
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
			:email,
			:time_zone,
			:show_ignored,
			# :avatar_image,
			password_authentication_attributes: [
				:password,
				:password_confirmation
			]
		)
	end

	def user_update_params
		params.require(:user).permit(
			:email,
			:time_zone,
			:page_size,
			:show_ignored,
			password_authentication_attributes: [
				:password,
				:password_confirmation
			]
		)
	end

end
