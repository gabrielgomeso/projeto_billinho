# frozen_string_literal: true

class FixColumnNameAgain < ActiveRecord::Migration[6.0]
  def change
    rename_column :institutions, :institution_type, :category
  end
end
