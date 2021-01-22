# frozen_string_literal: true

module Api
  module V1
    # Controller class for the Bills model
    class BillsController < ApplicationController
      # Execute the set_bill method before show, update and destroy
      before_action :set_bill, only: %i[show update destroy]

      # List all bills
      def index
        @bills = Bill.all
        render json: @bills
      end

      # Show a bill by the given id
      def show
        @bill = Bill.find(params[:id])
        render json: @bill
      end

      # Create a bill
      def create
        @bill = Bill.new(bill_params)
        if @bill.save
          render json: @bill
        else
          render error: { error: 'Unable to create Bill' }, status: 400
        end
      end

      # Update an enrollment
      def update
        if @bill.update(bill_params)
          render json: @bill
        else
          render error: { error: 'Unable to update Bill' }, status: 400
        end
      end

      # Delete an enrollment
      def delete
        if @bill.destroy
          render json: { message: 'Bill has been deleted' }, status: 200
        else
          render error: { error: 'Unable to delete Bill' }, status: 400
        end
      end

      private

      # Defines the allowed params to create/update the bill
      def bill_params
        params.require(:bill).permit(:bill_cost, :bill_due_date, :status, :enrollment_id)
      end

      # Finds a bill given the id
      def set_bill
        @bill = Bill.find(params[:id])
      end
    end
  end
end
