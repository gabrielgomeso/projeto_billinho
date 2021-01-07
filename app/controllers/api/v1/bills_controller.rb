class Api::V1::BillsController < ApplicationController
    def index
        @bills = Bill.all
        render json: @bills
    end

    def show 
        @bill = Bill.find(params[:id])
        render json: @bill
    end
    
    def create
        @bill = Bill.new(bill_params)
        if @bill.save 
            render json: @bill
        else
            render error: { error: 'Unable to create Bill' }, status: 400
        end
    end

    def update
    end

    def delete
    end

    private

    def bill_params
        params.require(:bill).permit(:bill_cost, :bill_due_date, :status, :enrollment_id)
    end
end
