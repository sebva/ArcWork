class HomeworksController < ApplicationController

  before_filter :authenticate_user!

  def index
    if current_user.isProfessor?
      @course = Course.find(params[:course_id])
      @homework = @course.homeworks
    else
      redirect_to home_index_path
    end
  end

  def show
    @course = Course.find(params[:course_id])
    @homework = Homework.find(params[:id])

    @extension = @homework.file.path.nil? ? 'No attached' : File.extname(@homework.file.path)[1..-1]

    if current_user.isProfessor?
      users = @homework.solutions.select(:user_id).distinct
      @solutions = []
      for user in users do
        last_solution = Solution.where("user_id = ?", user.user_id).sort_by { |sol| sol.date }.reverse.first
        @solutions.append(last_solution)
      end

      render '_show_uniq_solutions'
    elsif current_user.isStudent?
      render '_show_homework'
    else
      redirect_to home_index_path
    end
  end

  def new

    @course = Course.find(params[:course_id])
    @homework = Homework.new
    @homework.due_date = (Time.zone.now + 8.days).midnight - 1.seconds

    if not current_user.isProfessor?
      redirect_to course_homeworks_path(@course)
    end
  end

  def edit
    @course = Course.find(params[:course_id])
    @homework = Homework.find(params[:id])
    if not current_user.isProfessor?
      redirect_to course_homeworks_path(@course)
    end
  end

  def create
    if current_user.isProfessor?
      @course = Course.find(params[:course_id])
      @homework = Homework.new(get_params)
      @homework.course = @course
      if @homework.save
        redirect_to [@course, @homework]
      else
        render 'new'
      end
    else
      redirect_to course_homeworks_path(@course)
    end
  end

  def update
    if current_user.isProfessor?
      @course = Course.find(params[:course_id])
      @homework = Homework.find(params[:id])
      if @homework.update(get_params)
        redirect_to [@course, @homework]
      else
        render 'edit'
      end
    else
      redirect_to course_homeworks_path(@course)
    end
  end

  def destroy
    if current_user.isProfessor?
      @homework = Homework.find(params[:id])
      @homework.destroy
      course = Course.find(params[:course_id])
      redirect_to course_homeworks_url(course)
    else
      redirect_to course_homeworks_path(@course)
    end
  end

  def index_homework_to_do
    if current_user.isStudent?
      @title = "Homework to do"
      @homework = Array.new
      for course in current_user.courses
        @homework += course.homeworks.where("due_date >= ?", Time.now)
      end

    else
      redirect_to home_index_path
    end
  end

  def index_homework_done
    if current_user.isStudent?
      @title = "Past homework"

      @homework = Array.new
      for course in current_user.courses
        @homework += course.homeworks.where("due_date < ?", Time.now)
      end
      render "index_homework_to_do"
    else
      redirect_to home_index_path
    end
  end

  private

  def get_params
    params[:homework].permit(:title, :description, :due_date, :file)
  end



end
