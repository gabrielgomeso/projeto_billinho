class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :institutions, :type, :institution_type
  end
end
