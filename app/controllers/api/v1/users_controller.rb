class Api::V1::UsersController < ApplicationController

    def create
        user = User.create(user_params)
        puts user_params
        if user.valid?
            render json: { user: UserSerializer.new(user) }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def show
        user = User.find_by(id: params[:id])
        render json: { user: UserSerializer.new(user) }, status: :ok
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end
