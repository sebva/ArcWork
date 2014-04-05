class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :solutions
  has_and_belongs_to_many :courses
  has_many :courses_professor, :class_name => 'Course', :foreign_key => 'professor_id'

  RANK_STUDENT = 0
  RANK_PROFESSOR = 1
  RANK_DEAN = 2

  def rank_as_string
    case self.rank
      when RANK_DEAN
        return "Dean"
      when RANK_PROFESSOR
        return "Professor"
      when RANK_STUDENT
        return "Student"
      else
        return "Unknown"
    end
  end

  def name_not_null
    if name.nil? || name.empty?
      return email.html_safe
    end
    return name
  end

  def isStudent?
    self.rank == RANK_STUDENT
  end

  def isProfessor?
    self.rank == RANK_PROFESSOR
  end

  def isDean?
    self.rank == RANK_DEAN
  end

  def current_year_courses
    return self.courses_professor.where("start_year = ?", Course.get_current_year)
  end

end
