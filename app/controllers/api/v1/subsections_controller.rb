class Api::V1::SubsectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        subsection = Subsection.new(subsection_params)
        subsection.section_id = params[:section_id]
        subsection.save
        render json: SubsectionSerializer.new(subsection, params: {user: current_user}).serializable_hash, status: :created
    end

    def index
        subsections = Subsection.all
        render json: SubsectionSerializer.new(subsections ,{params: {user: current_user}}).serializable_hash, status: :ok
    end

    def show
        subsection = Subsection.find_by(id: params[:id])
        render json: SubsectionSerializer.new(subsection, {params: {user: current_user}}).serializable_hash, status: :ok
    end

    private

    def subsection_params
        params.require(:subsection).permit(:title)
    end

end
