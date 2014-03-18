class HomeworksController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @homework = @course.homeworks
  end

  def show
    @course = Course.find(params[:course_id])
    @homework = Homework.find(params[:id])
    @solutions = @homework.solutions.sort_by { |sol| sol[1] }.reverse
  end

  def new
    @course = Course.find(params[:course_id])
    @homework = Homework.new
  end

  def edit
    @course = Course.find(params[:course_id])
    @homework = Homework.find(params[:id])
  end

  def create
    @course = Course.find(params[:course_id])
    @homework = Homework.new(get_params)
    @homework.course = @course
    if @homework.save
      redirect_to [@course, @homework]
    else
      render 'new'
    end
  end

  def update
    @course = Course.find(params[:course_id])
    @homework = Homework.find(params[:id])
    if @homework.update(get_params)
      redirect_to [@course, @homework]
    else
      render 'edit'
    end
  end

  def destroy
    @homework = Homework.find(params[:id])
    @homework.destroy
    course = Course.find(params[:course_id])
    redirect_to course_homeworks_url(course)
  end

  private

  def get_params
    params[:homework].permit(:title, :description, :due_date, :file_path)
  end

end
