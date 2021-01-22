# frozen_string_literal: true

# Validates the student params
class Student < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cpf, presence: true, numericality: { only_integer: true }, length: { is: 11 }, uniqueness: true
  validates :cellphone, numericality: { only_integer: true }
  validates :genre, presence: true, inclusion: { in: %w[M F], message: '%{value} is not a valid genre' }
  validates :payment_method, presence: true,
                             inclusion: { in: %w[Boleto Cartão], message: '%{value} is not a valid payment method' }
end
