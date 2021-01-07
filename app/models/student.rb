class Student < ApplicationRecord
    has_many :enrollments

    validates :name, presence: true, uniqueness: true
    validates :cpf, presence: true, uniqueness: true, numerically: { only_integer: true }, length: { maximum: 14 }
    #validates birthday // não sei como validar data por aqui
    validates :cellphone, numerically: { only_integer: true }
    validates :genre, presence: true, inclusion: { in: %w(M F), message: "%{value} is not a valid genre" }
    validates :payment_method, presence: true, inclusion: { in: %w(Boleto Cartão), message: "%{value} is not a valid payment method" }
end