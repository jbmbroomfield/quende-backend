class Api::V1::UsersController < ApplicationController

    def create
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
        render_one
    end

    def current
        if current_user
            render_json(current_user)
        else
            render json: { error: "user not found" }, status: :not_acceptable
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :username,
            :email,
            password_authentication_attributes: [
                :password,
                :password_confirmation
            ]
        )
    end

end
