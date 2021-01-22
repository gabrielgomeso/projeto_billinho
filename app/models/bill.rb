# frozen_string_literal: true

# Validates the bill params
class Bill < ApplicationRecord
  belongs_to :enrollment

  validates :bill_cost, numericality: { only_decimal: true }, presence: true
  validates :bill_due_date, presence: true
  validates :status, presence: true,
                     inclusion: { in: %w[Aberta Atrasada Paga], message: '%{value} is not a valid status' }
  validates :enrollment_id, presence: true
end
