class CreateCoursesAndAssistants < ActiveRecord::Migration[5.0]
  def change
    create_table :assistants_courses do |t|
      t.belongs_to :course, foreign_key: true
      t.belongs_to :assistant, foreign_key: true
    end
  end
end
