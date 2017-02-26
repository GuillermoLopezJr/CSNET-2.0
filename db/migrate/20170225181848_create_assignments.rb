class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :due_date
      t.integer :course_num
      t.timestamps
    end
  end
end
