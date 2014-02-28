class Course < ActiveRecord::Base
  belongs_to :professor, :class_name => 'User'
  has_many :homeworks
  has_and_belongs_to_many :users
end
