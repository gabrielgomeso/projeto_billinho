class Api::V1::StudentsController < ApplicationController
    def index
        @students = Student.all
        render json: @students
    end

    def show 
        @student = Student.find(params[:id])
        render json: @student
    end
    
    def create
        @student = Student.new(student_params)
        if @student.save 
            render json: @student
        else
            render error: { error: 'Unable to create Student '}, status: 400
        end
    end

    private

    def student_params
        params.require(:student).permit(:name, :cpf, :birthday, :cellphone, :genre, :payment_method)
    end
end
