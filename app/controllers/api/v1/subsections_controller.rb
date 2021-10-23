class Api::V1::SubsectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        subsection = Subsection.create(subsection_params)
        if subsection.valid?
            render json: { section: SubsectionSerializer.new(subsection) }, status: :created
        else
            render json: { error: 'failed to create subsection' }, status: :not_acceptable
        end
    end

    private

    def subsection_params
        params.require(:subsection).permit(:title, :section_id)
    end

end
