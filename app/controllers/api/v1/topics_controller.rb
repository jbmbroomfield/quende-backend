class Api::V1::TopicsController < ApplicationController

    def create
        topic = Topic.new(topic_params)
        topic.subsection_id = params[:subsection_id]
        if topic.save
            render json: TopicSerializer.new(topic), status: :created
        else
            render json: { error: 'failed to create topic' }, status: :not_acceptable
        end
    end

    private

    def topic_params
        params.require(:topic).permit(:title)
    end

end
