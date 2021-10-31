class Api::V1::NotificationsController < ApplicationController

  before_action :require_login

  def index
    render_where(user: current_user)
  end

  def destroy
    notification = Notification.find_by(id: params[:id])
    if notification && current_user == notification.user
      notification.destroy
      render json: { message: "notification deleted" }, status: :ok
    else
      render json: { error: "notification not found" }, status: :not_acceptable
    end
  end

end
