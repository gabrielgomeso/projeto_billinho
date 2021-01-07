class Api::V1::InstitutionsController < ApplicationController
    # Executa, antes dos métodos show, update e destroy, o método set_institution
    before_action :set_institution, only: [:show, :update, :destroy]

    # Lista todas as instituições
    def index
        @institutions = Institution.all
        render json: @institutions
    end

    # Mostra uma instituição específica
    def show 
        render json: @institution
    end
    
    # Cria uma instituição
    def create
        @institution = Institution.new(institution_params)
        if @institution.save 
            render json: @institution
        else
            render error: { error: 'Unable to create Institution' }, status: 400
        end
    end

    # Atualiza uma instituição
    def update
        if @institution.update(institution_params)
            render json: @institution
        else
            render error: { error: 'Unable to update Institution' }, status: 400
        end
    end

    # Deleta uma instituição
    def destroy
        if @institution.destroy
            render json: { message: 'Institution has been deleted' }, status: 200
        else
            render error: { error: 'Unable to delete Institution' }, status: 400
        end
    end

    private

    # Define os parâmetros permitidos para crair/atualizar a instituição
    def institution_params
        params.require(:institution).permit(:name, :cnpj, :category)
    end

    # Define a instituição a partir do parâmetro dado
    def set_institution
        @institution = Institution.find(params[:id])
    end
end