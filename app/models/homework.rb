class Homework < ActiveRecord::Base
  belongs_to :course
  has_many :solutions

  has_attached_file :file
  validates_attachment :avatar
  do_not_validate_attachment_file_type :file
end
