class Api::V1::SubsectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        subsection = Subsection.new(subsection_params)
        subsection.section_id = params[:section_id]
        if subsection.save
            render json: SubsectionSerializer.new(subsection), status: :created
        else
            render json: { error: 'failed to create subsection' }, status: :not_acceptable
        end
    end

    def index
        subsections = Subsection.where(section_id: params[:section_id])
        options = {
            # include: [:section]
        }
        render json: SubsectionSerializer.new(subsections, options)
    end

    private

    def subsection_params
        params.require(:subsection).permit(:title)
    end

end
