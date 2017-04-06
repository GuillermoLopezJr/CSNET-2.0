class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.string :name
      t.string :attachment
      t.integer :student_id
      t.integer :assignment_id 
      t.timestamps
    end
  end
end
