class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.datetime :date
      t.attachment :file
      t.text :student_comment
      t.text :professor_comment
      t.string :mime
      t.integer :version
      t.references :homework, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
