class AddLastNameToInstructor < ActiveRecord::Migration[5.0]
  def change
    add_column :instructors, :last_name, :string
  end
end
