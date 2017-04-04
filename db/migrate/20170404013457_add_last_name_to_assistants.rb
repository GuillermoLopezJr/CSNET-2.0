class AddLastNameToAssistants < ActiveRecord::Migration[5.0]
  def change
    add_column :assistants, :last_name, :string
  end
end
