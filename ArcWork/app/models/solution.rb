class Solution < ActiveRecord::Base
  belongs_to :homework
  belongs_to :user
end
