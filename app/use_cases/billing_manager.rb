# Classe que gerencia a criacao de parcelas apos a criacao de matricula
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

  def perform
    values = generate_bill_values(course_total_cost, bill_quantity)
    generate_first_bill(bill_due_day, values[0])

    (bill_quantity - 1).times do |i|
      month = all_bills[0][:bill_due_date] + (i + 1).month
      i = i + 1
      value = if i == (bill_quantity - 1)
                values.last
              else
                values.first
              end

      bill = Bill.new({ "bill_cost": value, "bill_due_date": month, "status": 'Aberta',
                        "enrollment_id": enrollment_id })
      bill.save
      all_bills << bill
    end

    all_bills
  end

  # Gera os valores das parcelas, com o resto para a última parcela
  def generate_bill_values(course_total_cost, bill_quantity)
    values = []
    course_total_cost =  course_total_cost.to_f
    general = (course_total_cost / bill_quantity).round(2)

    last_value = general + (course_total_cost - (general * bill_quantity)).round(2)

    (bill_quantity - 1).times do |i|
      i = i + 1
      if i == (bill_quantity - 1)
          values << last_value
      else
          values << general
      end
    end

    values
  end

  # Gera a primeira fatura
  def generate_first_bill(bill_due_day, parcels)
    first_due_date = generate_first_due_date(bill_due_day)

    first_bill = Bill.new({ "bill_cost": parcels, "bill_due_date": first_due_date, "status": 'Aberta',
                            "enrollment_id": enrollment_id })
    first_bill.save
    all_bills << first_bill
  end

  # Gera a data de vencimento da primeira fatura
  def generate_first_due_date(due_day)
    due_day >= Time.now.mday ? validate_due_date(due_day) : validate_due_date(due_day).next_month
  end

  # Analisa a data entregue e retorna o último dia do mês caso ela seja invalida (Ex: 30/02)
  def validate_due_date(due_day)
    if Date.valid_date?(Date.today.year, Date.today.month, due_day)
      Date.new(Date.today.year, Date.today.month, due_day)
    else
      Date.civil(Date.today.year, Date.today.month, -1)
    end
  end
end
