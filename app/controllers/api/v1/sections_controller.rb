class Api::V1::SectionsController < ApplicationController

    before_action :require_admin, only: [:create]

    def create
        create_and_render
    end

    def index
        render_all
    end

    def show
        render_one
    end

    private

    def section_params
        params.require(:section).permit(:title)
    end

end