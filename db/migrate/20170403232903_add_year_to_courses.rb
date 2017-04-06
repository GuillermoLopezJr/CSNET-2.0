class AddYearToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :year, :string
  end
end
