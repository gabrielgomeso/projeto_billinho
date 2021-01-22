# frozen_string_literal: true

# Validates the enrollment params
class Enrollment < ApplicationRecord
  belongs_to :institution
  belongs_to :student

  has_many :bills

  validates :course_total_cost, numericality: { greater_than: 0 }, presence: true
  validates :bill_quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
  validates :bill_due_day, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }
  validates :course_name, presence: true
  validates :institution_id, presence: true
  validates :student_id, presence: true
end
