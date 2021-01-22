# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollments do |t|
      t.decimal :course_total_cost
      t.integer :bill_quantity
      t.integer :bill_due_day
      t.string :course_name
      t.references :institution, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
