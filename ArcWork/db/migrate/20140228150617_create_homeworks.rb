class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :title
      t.text :description
      t.datetime :due_date
      t.string :file_path
      t.references :course_id, index: true

      t.timestamps
    end
  end
end
