class Course < ActiveRecord::Base
  validates :name, :presence=> true
  validates :start_year, :inclusion => 2000..2200
  belongs_to :professor, :class_name => 'User'
  validates_associated :professor
  has_many :homeworks
  has_and_belongs_to_many :users


  # attr_reader(:user_id) is the same as:
  def last_user_id
    @last_user_id
  end

# attr_writer(:foo) is the same as:
  def last_user_id(new_value)
    @last_user_id = new_value
  end

# attr_accessor(:foo) is the same as:
  attr_reader(:last_user_id)
  attr_writer(:last_user_id)

  def self.get_current_year
    year = Time.now.year
    if Time.now.month < 8
      year -= 1
    end
    return year
  end
end
