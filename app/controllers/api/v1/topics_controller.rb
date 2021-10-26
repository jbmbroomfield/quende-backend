class Api::V1::TopicsController < ApplicationController

    def create
        topic = Topic.new(topic_params)
        topic.subsection_id = params[:subsection_id]
        save_and_render(topic)
    end
    
    def index
        render_where(subsection_id: params[:subsection_id])
    end

    def show
        render_one
    end

    private

    def topic_params
        params.require(:topic).permit(:title)
    end

end
