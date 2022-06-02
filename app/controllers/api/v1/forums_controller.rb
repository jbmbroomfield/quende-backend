class Api::V1::ForumsController < ApplicationController

  before_action :require_login, only: [:create]

  def create
   @forum = Forum.create(forum_params)
    if @forum.valid?
      @forum.make_super_admin(current_user)
      @status = :created
      render_forum
    else
      render_forum_not_created
    end
  end

  def index
    @forums = Forum.all
    render_forums
  end

  def show
    forum = Forum.find_by(slug: params[:forum_slug])
    if forum
      render_obj(forum)
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

	def render_forum
    @data = @forum.json(user: current_user)
    render_json
	end

	def render_forums
    @data = Forum.json(forums: @forums, user: current_user)
		render_json
	end

  def render_forum_not_created
    if @forum.errors.full_messages.include?("Slug must be unique")
      @errors = { "forum-create-title-input" => "Title unavailable." }
      @status = :forbidden
    else
      @error = "Forum not created."
      @status = :internal_server_error
    end
    render_json
  end

  def render_forum_not_found
    @errors = { slug: "Forum not found." }
    @status = :not_found
    render_json
  end

end