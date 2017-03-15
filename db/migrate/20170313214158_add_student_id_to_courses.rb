class AddStudentIdToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :student_id, :integer
  end
end
