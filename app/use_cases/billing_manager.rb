# frozen_string_literal: true

# Class that manages the creation of bills after the creation of the enrollment
class BillingManager
  include UseCase

  attr_reader :course_total_cost, :bill_quantity, :bill_due_day, :enrollment_id
  attr_accessor :all_bills

  def initialize(params, enrollment_id)
    @course_total_cost = params[:course_total_cost].to_f
    @bill_quantity = params[:bill_quantity]
    @bill_due_day = params[:bill_due_day]
    @enrollment_id = enrollment_id
    @all_bills = []
  end

  # Method to call all other methods that generates the bills, dates and values
  def perform
    values = generate_bill_values(course_total_cost, bill_quantity)
    generate_first_bill(bill_due_day, values[0])
    generate_bills(bill_quantity, values, all_bills)
  end

  # Generate the bills after the first one
  def generate_bills(bill_quantity, values, all_bills)
    (bill_quantity - 1).times do |i|
      month = all_bills[0][:bill_due_date] + (i + 1).month
      i += 1
      # The values[1] is the last value with remaining value, values[0] is the general bill value
      value = i == (bill_quantity - 1) ? values[1] : values[0]

      bill = Bill.new({ "bill_cost": value, "bill_due_date": month, "status": 'Aberta',
                        "enrollment_id": enrollment_id })
      bill.save
      all_bills << bill
    end

    all_bills
  end

  # Generate the bill values and the remaining value for the last bill
  def generate_bill_values(course_total_cost, bill_quantity)
    values = []
    course_total_cost = course_total_cost.to_f
    general = (course_total_cost / bill_quantity).round(2)
    values << general

    last_value = general + (course_total_cost - (general * bill_quantity)).round(2)
    values << last_value

    values
  end

  # Generate and saves the first bill
  def generate_first_bill(bill_due_day, parcels)
    first_due_date = generate_first_due_date(bill_due_day)

    first_bill = Bill.new({ "bill_cost": parcels, "bill_due_date": first_due_date, "status": 'Aberta',
                            "enrollment_id": enrollment_id })
    first_bill.save
    all_bills << first_bill
  end

  # Generate the due date for the first bill
  def generate_first_due_date(due_day)
    due_day >= Time.now.mday ? validate_due_date(due_day) : validate_due_date(due_day).next_month
  end

  # Analise the given day and retrieve the last day of the month case it's invalid (Ex: 30/02)
  def validate_due_date(due_day)
    if Date.valid_date?(Date.today.year, Date.today.month, due_day)
      Date.new(Date.today.year, Date.today.month, due_day)
    else
      Date.civil(Date.today.year, Date.today.month, -1)
    end
  end
end
