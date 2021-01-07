class Api::V1::EnrollmentsController < ApplicationController
    def index
        @enrollments = Enrollment.all
        render json: @enrollments
    end

    def show 
        @enrollment = Enrollment.find(params[:id])
        render json: @enrollment
    end
    
    def create
        @enrollment = Enrollment.new(enrollment_params)
        if @enrollment.save 
            render json: @enrollment
        else
            render error: { error: 'Unable to create Enrollment' }, status: 400
        end
    end

    private

    def enrollment_params
        params.require(:enrollment).permit(:course_total_cost, :bill_quantity, :bill_due_day, :course_name, :institution_id, :student_id)
    end
end
