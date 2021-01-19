# Classe que gerencia a criacao de parcelas apos a criacao de matricula
class BillingManager
  # include UseCase

  attr_accessor :due_day, :bills_quantity, :total_value, :enrollment_id

  # def initialize(params)
  #   @due_day = due_day
  #   @bills_quantity = bills_quantity
  #   @total_value = total_value
  # end

  def perform(due_day, bills_quantity, total_value, enrollment_id)
    all_bills = []
    parcels = (total_value.to_f / bills_quantity).round(2)
    first_due_date = generate_first_due_date(due_day)

    first_bill = Bill.new({ "bill_cost": parcels, "bill_due_date": first_due_date, "status": 'Aberta',
    "enrollment_id": enrollment_id })
    first_bill.save
    all_bills << first_bill

    (bills_quantity - 1).times do |i|
      month = all_bills[0][:bill_due_date] + (i + 1).month

      bill = Bill.new({ "bill_cost": parcels, "bill_due_date": month, "status": 'Aberta',
                        "enrollment_id": enrollment_id })
      bill.save
      all_bills << bill
    end

    all_bills
  end

  # Gera a primeira fatura
  def generate_first_due_date(due_day)
    due_day >= Time.now.mday ? validate_due_date(due_day) : validate_due_date(due_day).next_month
  end

  def validate_due_date(due_day)
    if Date.valid_date?(Date.today.year, Date.today.month, due_day)
      Date.new(Date.today.year, Date.today.month, due_day)
    else
      Date.civil(Date.today.year, Date.today.month, -1)
    end
  end
end