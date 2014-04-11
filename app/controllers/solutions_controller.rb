class SolutionsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @solution = Solution.new

    @homework = Homework.find(params[:homework_id])
    @course = Course.find(params[:course_id])
    #if professor show all solutions
    @user = User.find(current_user.id)

    if @user.isProfessor?
      # TODOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOoo
      @solutions = @homework.solutions
    elsif @user.isStudent?
      @solutions = []
      @solutions = @homework.solutions.where(user_id: @user.id)
    else
      # redirect_to root_path

    end
  end

  def create
    @homework = Homework.find(params[:homework_id])
    @course = @homework.course
    @user = current_user

    @solution = Solution.new(get_params)
    @solution.homework_id = @homework.id
    @solution.user_id = @user.id
    @solution.version = @homework.solutions.where(user_id: @user.id).size+1

    extension = @solution.file.path.nil? ? 'txt' : File.extname(@solution.file.path)[1..-1]
    @solution.mime = extension

    if @solution.save
      redirect_to [@course,@homework,Solution]
    end
  end

  def update
    @course = Course.find(params[:course_id])
    @homework = Homework.find(params[:homework_id])
    @solution = Solution.find(params[:id])
    if @solution.update(get_params)
      redirect_to [@course, @homework, Solution]
    else
      render 'solutions'
    end
  end

  private

  def solution_params
    params.require(:solution).permit(:avatar)
  end

  def get_params
    params[:solution].permit(:mime, :date, :file, :student_comment, :professor_comment,:version, :avatar)
  end
end
