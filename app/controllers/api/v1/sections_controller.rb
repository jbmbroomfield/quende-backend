class Api::V1::SectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        section = Section.create(section_params)
        if section.valid?
            render json: { section: SectionSerializer.new(section) }, status: :created
        else
            render json: { error: 'failed to create section' }, status: :not_acceptable
        end
    end

    private

    def section_params
        params.require(:section).permit(:title)
    end

end