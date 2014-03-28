class CoursesController < ApplicationController
  def index
    if(!current_user.nil? && current_user.isDean?)
      couses_add_view_init

    else
      redirect_to root_url
    end

  end

  def show
    if(!current_user.nil? && current_user.isProfessor?)


    else
      redirect_to root_url
    end
  end

  def edit
    if(!current_user.nil? && current_user.isDean?)
      @course = Course.find(params[:id])
      @professors = User.all
    else
      redirect_to root_url
    end
  end

  def new
    if(!current_user.nil? && current_user.isDean?)
      @course = Course.new
      @professors = User.all
      @course.start_year = Course.get_current_year
    else
      redirect_to root_url
    end
  end

  def create
    if(!current_user.nil? && current_user.isDean?)
      @course = Course.create(params[:course].permit(:name, :start_year, :professor_id))
      if @course.valid?
        redirect_to action: "index"

      else
        @course.errors.each do |attribute, error|
          flash.now[:error] = Course.human_attribute_name(attribute) + " " +  error.to_s
        end
        @course.errors.clear
        @professors = User.all
        render "new"
      end
    else
      redirect_to root_url
    end
  end

  def update
    if(!current_user.nil? && current_user.isDean?)
      @course = Course.find(params[:id])

      if @course.update(params[:course].permit(:name, :start_year, :professor_id))
        redirect_to action: "index"
      else
        @course.errors.each do |attribute, error|
          flash.now[:error] = Course.human_attribute_name(attribute) + " " +  error.to_s        end
        @course.errors.clear
        @professors = User.all
        render 'edit'
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    if(!current_user.nil? && current_user.isDean?)
      @course = Course.find(params[:id])
      if @course.destroy
        redirect_to action: "index"
      else
        render 'delete'
      end
    else
      redirect_to root_url
    end

  end


  def couses_add_view_init()
    @curr_year = params[:year]
    if params[:year].nil?
      @curr_year = Course.get_current_year
    else
      @curr_year =params[:year].to_i
    end

    @min_year = Course.minimum("start_year")
    if  @min_year.nil?
      @min_year = Course.get_current_year
    else
      @min_year = @min_year.to_i
    end
    @min_year = Course.get_current_year if @min_year > Course.get_current_year


    @max_year = Course.maximum("start_year")
    if  @max_year.nil?
      @max_year = Course.get_current_year
    else
      @max_year = @max_year.to_i
    end
    @max_year = Course.get_current_year if @max_year < Course.get_current_year
    @courses = Course.where(start_year: @curr_year)
  end

end
