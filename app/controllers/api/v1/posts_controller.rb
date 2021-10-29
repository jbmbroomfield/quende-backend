class Api::V1::PostsController < ApplicationController

    before_action :require_login, only: [:create]

    def create
        post = Post.new(post_params)
        post.topic_id = params[:topic_id]
        post.user = current_user
        # post.tag = Post.count.to_s
        save_and_render(post)
    end
    
    def index
        render_where(topic_id: params[:topic_id])
    end

    private

    def post_params
        params.require(:post).permit(
            :user_id,
            :text
        )
    end

end
