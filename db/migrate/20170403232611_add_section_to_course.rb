class AddSectionToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :section, :integer
  end
end
