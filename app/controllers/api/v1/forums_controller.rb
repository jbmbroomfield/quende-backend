class Api::V1::ForumsController < ApplicationController

  before_action :require_login, only: [:create]

  def create
    forum = Forum.create(forum_params)
    if forum.valid?
      forum.make_super_admin(current_user)
      render json: ForumSerializer.new(forum), status: :created
    else
      render_forum_not_created(forum)
    end
  end

  def index
    forums = Forum.all.map{ |forum| forum.json(current_user) }
    json = {
      success: true,
      forums: forums,
    }
    render json: json, status: :ok
  end

  def show
    forum = Forum.find_by(slug: params[:forum_slug])
    if forum
      render json: ForumSerializer.new(forum), status: :ok
    else
      render_forum_not_found
    end
  end

  private

  def forum_params
    params.require(:forum).permit(
      :title,
      :description,
      permissions: [:view, :url_view, :post, :password_post, :create_topic, :create_subsection, :create_section],
    )
  end

  def render_forum_not_created(forum)
    if forum.errors.full_messages.include?("Slug must be unique")
      render json: {
        errors: {
          "forum-create-title-input": "Title unavailable."
        }
      }, status: :forbidden
    else
      render json: {
        errors: {
          error: "Forum not created."
        }
      }, status: :internal_server_error
    end
  end

  def render_forum_not_found
    render json: {
      errors: {
        slug: "Forum not found."
      }
    }, status: :not_found
  end

end