class CoursesController < ApplicationController
  def index
    @curr_year = params[:year]
    if params[:year].nil?
      @curr_year = get_current_year
    else
      @curr_year =params[:year].to_i
    end

    @min_year = Course.minimum("start_year")
    if  @min_year.nil?
      @min_year = get_current_year
    else
      @min_year = @min_year.to_i
    end
    @min_year = get_current_year if @min_year > get_current_year


    @max_year = Course.maximum("start_year")
    if  @max_year.nil?
      @max_year = get_current_year
    else
      @max_year = @max_year.to_i
    end
    @max_year = get_current_year if @max_year < get_current_year
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
    @course.start_year = get_current_year
  end

  def create
    @course = Course.create(params[:course].permit(:name, :start_year, :professor_id))
    if @course.valid?
      redirect_to action: "index"

    else
      @course.errors.each do |attribute, error|
        flash.now[:error] = attribute.to_s + " " +  error.to_s
      end
      @course.errors.clear
      @professors = User.all
      render "new"
    end
  end

  def update
    @course = Course.find(params[:id])

    if @course.update(params[:course].permit(:name, :start_year, :professor_id))
      redirect_to action: "index"
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      redirect_to action: "index"
    else
      render 'delete'
    end

  end

  def get_current_year()
    year = Time.now.year;
    if Time.now.month < 8
      year -= 1
    end
    return year
  end
end
