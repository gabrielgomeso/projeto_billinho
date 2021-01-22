# frozen_string_literal: true

module Api
  module V1
    # Controller class for the Institution model
    class InstitutionsController < ApplicationController
      # Execute the set_institution method before show, update and destroy
      before_action :set_institution, only: %i[show update destroy]

      # List all institutions
      def index
        @institutions = Institution.all
        render json: @institutions
      end

      # Show an institution by the given id
      def show
        render json: @institution
      end

      # Create an institution
      def create
        @institution = Institution.new(institution_params)
        if @institution.save
          render json: @institution
        else
          render error: { error: 'Unable to create Institution' }, status: 400
        end
      end

      # Update an enrollment
      def update
        if @institution.update(institution_params)
          render json: @institution
        else
          render error: { error: 'Unable to update Institution' }, status: 400
        end
      end

      # Delete an enrollment
      def destroy
        if @institution.destroy
          render json: { message: 'Institution has been deleted' }, status: 200
        else
          render error: { error: 'Unable to delete Institution' }, status: 400
        end
      end

      private

      # Defines the allowed params to create/update the institution
      def institution_params
        params.require(:institution).permit(:name, :cnpj, :category)
      end

      # Finds an institution given the id
      def set_institution
        @institution = Institution.find(params[:id])
      end
    end
  end
end
