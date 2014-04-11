class Solution < ActiveRecord::Base
  belongs_to :homework
  belongs_to :user

  has_attached_file :file
  # validates_attachment_content_type :file_path, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates_attachment :file, :size => { :in => 0..10.megabytes }
  do_not_validate_attachment_file_type :file

end
