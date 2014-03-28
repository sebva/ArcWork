class Course < ActiveRecord::Base
  validates :name, :presence=> true
  validates :start_year, :inclusion => 2000..2200
  belongs_to :professor, :class_name => 'User'
  validates_associated :professor
  has_many :homeworks
  has_and_belongs_to_many :users

  def self.get_current_year
    year = Time.now.year
    if Time.now.month < 8
      year -= 1
    end
    return year
  end
end
