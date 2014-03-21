class SolutionsController < ApplicationController
  def index

    @homework = Homework.find(params[:homework_id])
    @course = Course.find(params[:course_id])
    #if professor show all solutions
    @user = User.find(current_user.id)

    if @user.isProfessor?
      @solution = @homework.solutions
    elsif @user.isStudent?
      @solution = @homework.solutions.where(user_id: @user.id)
    else
      redirect_to root_path
    end
  end

  def new
    @homework = Homework.find(params[:homework_id])
    @user = current_user
    @solution = Solution.new
  end

  def create
    @homework = Homework.find(params[:homework_id])
    @course = @homework.course
    @user = current_user

    @solution = Solution.new(get_params)
    @solution.homework_id = @homework.id
    @solution.user_id = @user.id
    @solution.version = 1

    if @solution.save
      redirect_to [@course,@homework,@solution]
    else
      render 'new'
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

  def get_params
    params[:solution].permit(:mime, :date, :file_path, :student_comment, :professor_comment,:version)
  end
end
