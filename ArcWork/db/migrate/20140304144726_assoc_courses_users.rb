class AssocCoursesUsers < ActiveRecord::Migration
  def change
    create_table :courses_users do |t|
      t.belongs_to :user
      t.belongs_to :course
    end
  end
end