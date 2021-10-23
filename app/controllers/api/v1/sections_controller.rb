class Api::V1::SectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        section = Section.create(section_params)
        if section.valid?
            render json: SectionSerializer.new(section), status: :created
        else
            render json: { error: 'failed to create section' }, status: :not_acceptable
        end
    end

    def index
        sections = Section.all
        render json: SectionSerializer.new(sections)
    end

    def show
        section = Section.find_by(id: params[:id])
        if section
            render json: SectionSerializer.new(section)
        else
            render json: { error: 'section not found' }, status: :not_acceptable
        end
    end

    private

    def section_params
        params.require(:section).permit(:title)
    end

end