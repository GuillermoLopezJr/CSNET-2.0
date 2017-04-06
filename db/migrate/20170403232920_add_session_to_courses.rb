class AddSessionToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :session, :string
  end
end
