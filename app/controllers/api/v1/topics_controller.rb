class Api::V1::TopicsController < ApplicationController

    def create
        topic = Topic.create(topic_params)
        topic.subsection_id = params[:subsection_id]
        post_params = params.require(:post).permit(
            :text
        )
        post_params[:user] = current_user
        post_params[:topic] = topic
        post = Post.new(post_params)
        post.save
        save_and_render(topic)
    end
    
    def index
        render_all
    end

    def show
        render_one
    end

    private

    def topic_params
        params.require(:topic).permit(
            :title,
        )
    end

end
