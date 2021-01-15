class BillingManager
    # include UseCase

    attr_accessor :due_day, :bills_quantity, :total_value, :enrollment_id

    # def initialize(due_day, bills_quantity, total_value)
    #     @due_day = due_day
    #     @bills_quantity = bills_quantity
    #     @total_value = total_value

    #     perform(due_day, bills_quantity, total_value)
    # end

    def perform(due_day, bills_quantity, total_value, enrollment_id)
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
            next_month = due_dates[i][:due_date].next_month
            due_dates <<  { :due_date => next_month, :value => parcels }
        end

        billing_creation(due_dates, bills_quantity, enrollment_id)
    end

    def billing_creation(due_dates, bills_quantity, enrollment_id)
        all_bills = []
            
        bills_quantity.times do |i|
            due_date = due_dates[i][:due_date]
            value = due_dates[i][:value]
                
            bill = Bill.new({ "bill_cost": value, "bill_due_date": due_date, "status": "Aberta", "enrollment_id": enrollment_id })
            bill.save
            all_bills << bill
        end
    
        return all_bills
    end
end