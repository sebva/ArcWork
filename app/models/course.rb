class Course < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :professor, :class_name => 'User'
  validates_associated :professor
  has_many :homeworks
  has_and_belongs_to_many :users
end
