class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student

  has_many :bills

  validates :course_total_cost, numerically: { only_decimal: true }, presence: true 
end


# Enrollment #Matrícula
# enrollment_id KEY UNIQUE NOTNULL
# course_total_cost DECIMAL NOTNULL 0 >
# bill_quantity INT NOTNULL >= 1 #quantidade de faturas
# bill_due_day INT NOTNULL >= 1 and <= 31 #dia de vencimento das faturas
# course_name TEXT NOTNULL
# institution_id FOREIGNKEY NOTNULL
# student_id FOREIGNKEY NOTNULL