class Homework < ActiveRecord::Base
  belongs_to :course
  has_many :solutions
end
