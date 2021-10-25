class Api::V1::SectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        create_and_render(Section)
    end

    def index
        render_all
    end

    def show
        render_one(Section)
    end

    private

    def section_params
        params.require(:section).permit(:title)
    end

end