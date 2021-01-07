class Api::V1::StudentsController < ApplicationController
    # Executa, antes dos métodos show, update e destroy, o método set_student
    before_action :set_student, only: [:show, :update, :destroy]
    
    # Lista todos os estudantes
    def index
        @students = Student.all
        render json: @students
    end

    # Mostra um estudante específico
    def show 
        render json: @student
    end
    
    # Cria um estudante
    def create
        @student = Student.new(student_params)
        if @student.save 
            render json: @student
        else
            render error: { error: 'Unable to create Student '}, status: 400
        end
    end

    # Atualiza um estudante
    def update
        if @student.update(student_params)
            render json: @student
        else
            render error: { error: 'Unable to update Student' }, status: 400
        end
    end

    # Deleta um estudante
    def destroy
        if @student.destroy
            render json: { message: 'Student has been deleted' }, status: 200
        else
            render error: { error: 'Unable to delete Student' }, status: 400
        end
    end

    private

    # Define os parâmetros permitidos para criar/atualizar o estudante
    def student_params
        params.require(:student).permit(:name, :cpf, :birthday, :cellphone, :genre, :payment_method)
    end

    # Encontra o estudante a partir do id dado
    def set_student
        @student = Student.find(params[:id])
    end
end