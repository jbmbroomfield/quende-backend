class Api::V1::SubsectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        subsection = Subsection.create(subsection_params)
        if subsection.valid?
            render json: SubsectionSerializer.new(subsection), status: :created
        else
            render json: { error: 'failed to create subsection' }, status: :not_acceptable
        end
    end

    def index
        subsections = Subsection.all
        options = {
            include: [:section]
        }
        render json: SubsectionSerializer.new(subsections, options)
    end

    private

    def subsection_params
        params.require(:subsection).permit(:title, :section_id)
    end

end
