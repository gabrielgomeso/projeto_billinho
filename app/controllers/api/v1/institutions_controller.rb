class Api::V1::InstitutionsController < ApplicationController
    def index
        @institutions = Institution.all
        render json: @institutions
    end

    def show 
        @institution = Institution.find(params[:id])
        render json: @institution
    end
    
    def create
        @institution = Institution.new(institution_params)
        if @institution.save 
            render json: @institution
        else
            render error: { error: 'Unable to create Institution '}, status: 400
        end
    end

    private

    def institution_params
        params.require(:institution).permit(:name, :cnpj, :category)
    end
end