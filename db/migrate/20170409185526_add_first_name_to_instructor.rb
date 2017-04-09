class AddFirstNameToInstructor < ActiveRecord::Migration[5.0]
  def change
    add_column :instructors, :first_name, :string
  end
end
