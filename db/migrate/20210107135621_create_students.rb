# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students do |t|
      t.string :name
      t.integer :cpf
      t.datetime :birthday
      t.integer :cellphone
      t.string :genre
      t.string :payment_method

      t.timestamps
    end
  end
end
