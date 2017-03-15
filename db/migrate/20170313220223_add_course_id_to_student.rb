class AddCourseIdToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :course_id, :integer
  end
end
