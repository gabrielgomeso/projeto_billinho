class Api::V1::BillsController < ApplicationController
    # Executa, antes dos métodos show, update e destroy, o método set_bill
    before_action :set_bill, only: [:show, :update, :destroy]

    # Lista todas as faturas
    def index
        @bills = Bill.all
        render json: @bills
    end

    # Mostra uma fatura específica
    def show 
        @bill = Bill.find(params[:id])
        render json: @bill
    end
    
    # Cria uma fatura
    def create
        @bill = Bill.new(bill_params)
        if @bill.save 
            render json: @bill
        else
            render error: { error: 'Unable to create Bill' }, status: 400
        end
    end

    # Atualiza uma fatura
    def update
        if @bill.update(bill_params)
            render json: @bill
        else
            render error: { error: 'Unable to update Bill' }, status: 400
        end
    end

    # Deleta uma fatura
    def delete
        if @bill.destroy
            render json: { message: 'Bill has been deleted' }, status: 200
        else
            render error: { error: 'Unable to delete Bill' }, status: 400
        end
    end

    private

    # Define os parâmetros permitidos para crair/atualizar a fatura
    def bill_params
        params.require(:bill).permit(:bill_cost, :bill_due_date, :status, :enrollment_id)
    end

    # Encontra a fatura a partir do id dado
    def set_bill
        @bill = Bill.find(params[:id])
    end
end
