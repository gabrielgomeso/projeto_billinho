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
        bills = Bill.where(enrollment_id: params[:id])
        render json: { data: @enrollment, bills: bills }
    end
    
    # Cria uma matrícula
    def create
        @enrollment = Enrollment.new(enrollment_params)
        if @enrollment.save 
    
        parcela = @enrollment[:course_total_cost] / @enrollment[:bill_quantity] 
        primeira_fatura = primeira_fatura_maker(@enrollment[:bill_due_day])

        @enrollment[:bill_quantity].times do
            bill = Bill.new({ 
                "bill_cost": parcela,
                "bill_due_date": primeira_fatura,
                "status": "Aberta",
                "enrollment_id": @enrollment[:id]
            })

            bill.save
        end
    
            render json: @enrollment
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


    # require 'date'
    # require 'time'
        
    # def billingDates(due_day, bills_quantity)
    # due_dates = []

    # today = Date.today.day
    # this_month = Date.today.month
    # next_month = Date.today.next_month.month
    # this_year = Date.today.year 

    # if due_day >= Time.now.mday
    #     first_due_date = Date.new(this_year, this_month, due_day) # o dia de vencimento ainda é esse mês
    # else
    #     first_due_date = Date.new(this_year, next_month, due_day) # o dia de vencimento ainda é o mês seguinte
    # end

    # due_dates << first_due_date

    # (bills_quantity - 1).times do
    #     due_dates << first_due_date
    # end

    # puts due_dates
    # end

    # billingDates(20, 6)
end