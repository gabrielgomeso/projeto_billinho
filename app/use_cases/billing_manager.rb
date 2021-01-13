class BillingManager
    # include UseCase

    attr_accessor :due_day, :bills_quantity, :total_value

    # def initialize(due_day, bills_quantity, total_value)
    #     @due_day = due_day
    #     @bills_quantity = bills_quantity
    #     @total_value = total_value

    #     perform(due_day, bills_quantity, total_value)
    # end

    def perform(due_day, bills_quantity, total_value)
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

        return due_dates
    end

    def billing_creation (due_dates)
    
    
    end
end