class AddLastNameToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :last_name, :string
  end
end
