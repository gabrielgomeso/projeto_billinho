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

        bills = billingDates(@enrollment[:bill_due_day], @enrollment[:bill_quantity] , @enrollment[:course_total_cost])
        
        all_bills = []
        
        bills.length.times do |i|
            due_date = bills[i][:due_date]
            value = bills[i][:value]
            
            bill = Bill.new({ "bill_cost": value, "bill_due_date": due_date, "status": "Aberta", "enrollment_id": @enrollment[:id] })
            bill.save
            all_bills << bill
        end
        render json: { status: '200', message: "Registration saved with id #{@enrollment[:id]}", data: @enrollment, bills: all_bills }, status: :ok
    
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

    require 'date'
    
    def billingDates(due_day, bills_quantity, total_value)
        due_dates = []
        parcels = (total_value.to_f / bills_quantity.to_f).round(2)

        today = Date.today.day
        this_month = Date.today.month
        next_month = Date.today.next_month.month
        this_year = Date.today.year 

        if due_day >= Time.now.mday
            first_due_date = Date.new(this_year, this_month, due_day) # o dia de vencimento ainda é esse mês
        else
            first_due_date = Date.new(this_year, next_month, due_day) # o dia de vencimento ainda é o mês seguinte
        end

        formatted_date = first_due_date.strftime('%d-%m-%Y')

        first_bill = { :due_date => first_due_date, :value => parcels }

        due_dates <<  first_bill

        (bills_quantity - 1).times do |i|
            due_dates <<  { :due_date => due_dates[i][:due_date].next_month, :value => parcels }
        end

        due_dates
    end
end