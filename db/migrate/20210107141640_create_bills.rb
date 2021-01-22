# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.decimal :bill_cost
      t.datetime :bill_due_date
      t.string :status
      t.references :enrollment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
