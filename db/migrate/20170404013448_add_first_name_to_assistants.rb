class AddFirstNameToAssistants < ActiveRecord::Migration[5.0]
  def change
    add_column :assistants, :first_name, :string
  end
end
