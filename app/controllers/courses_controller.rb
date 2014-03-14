class CoursesController < ApplicationController
  def index
    @min_year = Course.minimum("start_year")
    @min_year = Time.now.year if @min_year.nil?
    @curr_year = params[:year]
    @curr_year = Time.now.year if @curr_year.nil?
    @courses = Course.where(start_year: @curr_year)
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end
end
