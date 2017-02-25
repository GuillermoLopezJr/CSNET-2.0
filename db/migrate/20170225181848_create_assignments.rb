class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :due_date
      t.string :course

      t.timestamps
    end
  end
end
