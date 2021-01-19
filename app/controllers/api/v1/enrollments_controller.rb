class Api::V1::EnrollmentsController < ApplicationController
    # Executa, antes dos métodos show, update e destroy, o método set_enrollment
    before_action :set_enrollment, only: [:show, :update, :destroy]
    
    # Lista todas as matrículas
    def index
        @enrollments = Enrollment.all
        render json: @enrollments
    end

    # Mostra uma matrícula específica
    def show 
        render json: @enrollment
    end

    # Cria uma matrícula
    def create
        @enrollment = Enrollment.new(enrollment_params)
        if @enrollment.save 
            # Retorna um array com as parcelas já salvas no banco
            bills = BillingManager.new.perform(@enrollment[:bill_due_day], @enrollment[:bill_quantity] , @enrollment[:course_total_cost], @enrollment[:id])            
            render json: { status: '200', message: "Registration saved with id #{@enrollment[:id]}", data: @enrollment, bills: bills }, status: :ok
        else
            render error: { error: 'Unable to create Enrollment' }, status: 400
        end
    end

    # Atualiza uma matrícula
    def update
        if @enrollment.update(enrollment_params)
            render json: @enrollment
        else
            render error: { error: 'Unable to update Enrollment' }, status: 400
        end 
    end

    # Deleta uma matrícula
    def destroy
        if @enrollment.destroy
            render json: { message: 'Enrollment has been deleted' }, status: 200
        else
            render error: { error: 'Unable to delete Enrollment' }, status: 400
        end
    end

    private

    # Define os parâmetros permitidos para crair/atualizar a matrícula
    def enrollment_params
        params.require(:enrollment).permit(:course_total_cost, :bill_quantity, :bill_due_day, :course_name, :institution_id, :student_id)
    end

    # Encontra a matrícula a partir do id dado
    def set_enrollment
        @enrollment = Enrollment.find(params[:id])
    end
end