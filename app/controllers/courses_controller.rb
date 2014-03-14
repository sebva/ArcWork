class CoursesController < ApplicationController
  def index
    @min_year = Course.minimum("start_year")
    @min_year = Time.now.year if @min_year.nil?
    @curr_year = params[:year]
    @curr_year = Time.now.year if @curr_year.nil?
    @courses = Course.where(start_year: @curr_year)
  end

  def show
    @course = Course.find(params[:id])
  end

  def edit
    @course = Course.find(params[:id])
    @professors = User.all
  end

  def new
    @course = Course.new
    @professors = User.all
    @course.start_year = Time.now.year
    if(Time.now.month < 8)
      @course.start_year -=1
    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end
