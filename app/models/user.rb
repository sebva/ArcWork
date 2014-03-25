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

  def isStudent?
    self.rank == RANK_STUDENT
  end

  def isProfessor?
    self.rank == RANK_PROFESSOR
  end

  def isDean?
    self.rank == RANK_DEAN
  end

end
