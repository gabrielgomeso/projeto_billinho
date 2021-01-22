# frozen_string_literal: true

module Api
  module V1
    # Controller class for the Student model
    class StudentsController < ApplicationController
      # Execute the set_student method before show, update and destroy
      before_action :set_student, only: %i[show update destroy]

      # List all students
      def index
        @students = Student.all
        render json: @students
      end

      # Show an student by the given id
      def show
        render json: @student
      end

      # Create a student
      def create
        @student = Student.new(student_params)
        if @student.save
          render json: @student
        else
          render error: { error: 'Unable to create Student ' }, status: 400
        end
      end

      # Update a student
      def update
        if @student.update(student_params)
          render json: @student
        else
          render error: { error: 'Unable to update Student' }, status: 400
        end
      end

      # Delete a student
      def destroy
        if @student.destroy
          render json: { message: 'Student has been deleted' }, status: 200
        else
          render error: { error: 'Unable to delete Student' }, status: 400
        end
      end

      private

      # Defines the allowed params to create/update the student
      def student_params
        params.require(:student).permit(:name, :cpf, :birthday, :cellphone, :genre, :payment_method)
      end

      # Finds a student given the id
      def set_student
        @student = Student.find(params[:id])
      end
    end
  end
end
