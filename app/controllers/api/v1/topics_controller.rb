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
    
    def index
        topics = Topic.where(subsection_id: params[:subsection_id])
        render json: TopicSerializer.new(topics)
    end

    def show
        topic = Topic.find_by(id: params[:id])
        if topic
            render json: TopicSerializer.new(topic)
        else
            render json: { error: 'topic not found' }, status: :not_acceptable
        end
    end

    private

    def topic_params
        params.require(:topic).permit(:title)
    end

end
