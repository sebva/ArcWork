class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.int :start_year
      t.references :user, index: true

      t.timestamps
    end
  end
end
