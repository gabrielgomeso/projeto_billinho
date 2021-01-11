class ChangeCpFtoBeStringInStudentColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :students, :cpf, :string
  end
end
