# frozen_string_literal: true

module Api
  module V1
    # Controller class for the Enrollment model
    class EnrollmentsController < ApplicationController
      # Execute the set_enrollment method before show, update and destroy
      before_action :set_enrollment, only: %i[show update destroy]

      # List all enrollments
      def index
        @enrollments = Enrollment.all
        render json: @enrollments
      end

      # Show an enrollment by the given id
      def show
        render json: @enrollment
      end

      # Create an enrollment and the bills related to it
      def create
        @enrollment = Enrollment.new(enrollment_params)
        if @enrollment.save
          # Create all bills for this enrollment and return all bills created in an array
          bills = BillingManager.perform(enrollment_params, @enrollment[:id]).all_bills
          render json: { status: '200', message: "Registration saved with id #{@enrollment[:id]}", data: @enrollment, bills: bills }, status: :ok
        else
          render error: { error: 'Unable to create Enrollment' }, status: 400
        end
      end

      # Update an enrollment
      def update
        if @enrollment.update(enrollment_params)
          render json: @enrollment
        else
          render error: { error: 'Unable to update Enrollment' }, status: 400
        end
      end

      # Delete an enrollment
      def destroy
        if @enrollment.destroy
          render json: { message: 'Enrollment has been deleted' }, status: 200
        else
          render error: { error: 'Unable to delete Enrollment' }, status: 400
        end
      end

      private

      # Defines the allowed params to create/update the enrollment
      def enrollment_params
        params.require(:enrollment).permit(:course_total_cost, :bill_quantity, :bill_due_day, :course_name,
                                          :institution_id, :student_id)
      end

      # Finds an enrollment given the id
      def set_enrollment
        @enrollment = Enrollment.find(params[:id])
      end
    end
  end
end
