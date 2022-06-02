class Api::V1::ForumsController < ApplicationController

  before_action :require_login, only: [:create]

  def create
   @forum = Forum.create(forum_params)
   @forum.valid? ? forum_created : forum_not_created
  end

  def index
    @forums = Forum.all
    forums
  end

  def show
    @forum = Forum.find_by(slug: params[:forum_slug])
    @forum ? forum : forum_not_found
  end

  private

  def forum_params
    params.require(:forum).permit(
      :title,
      :description,
      permissions: [:view, :url_view, :post, :password_post, :create_topic, :create_subsection, :create_section],
    )
  end

	def forum
    @data = @forum.json(user: current_user)
	end

  def forum_created
    @forum.make_super_admin(current_user)
    @status = :created
    forum
  end

	def forums
    @data = Forum.json(forums: @forums, user: current_user)
	end

  def forum_not_created
    if @forum.errors.full_messages.include?("Slug must be unique")
      @errors = { "forum-create-title-input" => "Title unavailable." }
      @status = :forbidden
    else
      @error = "Forum not created."
      @status = :internal_server_error
    end
  end

  def forum_not_found
    @errors = { slug: "Forum not found." }
    @status = :not_found
  end

end