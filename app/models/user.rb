class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  validates :password,              :presence => true,    :if => :password_required?
  validates :password_confirmation, :presence => true,    :if => :password_required?

  has_many :solutions
  has_and_belongs_to_many :courses
  has_many :courses_professor, :class_name => 'Course', :foreign_key => 'professor_id'

  RANK_STUDENT = 0
  RANK_PROFESSOR = 1
  RANK_DEAN = 2

  def rank_as_string
    case self.rank
      when RANK_DEAN
        return 'Dean'
      when RANK_PROFESSOR
        return 'Professor'
      when RANK_STUDENT
        return 'Student'
      else
        return 'Unknown'
    end
  end

  def name_not_null
    if name.nil? || name.empty?
      return email.html_safe
    end
    name
  end

  def is_student?
    self.rank == RANK_STUDENT
  end

  def is_professor?
    self.rank == RANK_PROFESSOR
  end

  def is_dean?
    self.rank == RANK_DEAN
  end

  def current_year_courses
    self.courses_professor.where('start_year = ?', Course.get_current_year)
  end

  def password_required?
    # If resetting the password
    return true if reset_password_token.present? && reset_password_period_valid?

    # If the person already has a pass, only validate if they are updating pass
    unless encrypted_password.blank?
      password.present? || password_confirmation.present?
    end
  end
end
