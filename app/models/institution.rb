# frozen_string_literal: true

# Validates the institution params
class Institution < ApplicationRecord
  has_many :enrollments

  validates :name, presence: true, uniqueness: true
  validates :cnpj, presence: true, numericality: { only_integer: true }, length: { is: 14 }, uniqueness: true
  validates :category, presence: true,
                       inclusion: { in: %w[Universidade Escola Creche], message: '%{value} is not a valid category' }
end
