class Api::V1::SubsectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        subsection = Subsection.new(subsection_params)
        subsection.section_id = params[:section_id]
        save_and_render(subsection)
    end

    def index
        render_all
    end

    private

    def subsection_params
        params.require(:subsection).permit(:title)
    end

end
