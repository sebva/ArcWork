class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :start_year
      t.belongs_to :professor, index: true, :class_name => "User"

      t.timestamps
    end
  end
end
