class Api::V1::UserForumsController < ApplicationController

  before_action :require_user

  def show
    forum = Forum.find_by(slug: params[:forum_slug])
    if forum
      user_forum = forum.user_forum(current_user)
      p ['--uf--', user_forum.errors.full_messages]
      render json: UserForumSerializer.new(user_forum), status: :ok
    else
      render_forum_not_found
    end
  end

  private

  
  def render_no_user
    render json: {
      errors: {
        slug: "Current user not found."
      }
    }, status: :not_found
  end

  def render_forum_not_found
    render json: {
      errors: {
        slug: "Forum not found."
      }
    }, status: :not_found
  end

end