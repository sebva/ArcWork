class CoursesController < ApplicationController
  def index
    #Check access rights
    if !current_user.nil? && current_user.is_dean?
      couses_add_view_init

    else
      redirect_to root_url
    end

  end

  def show
    #Check access rights
    if !current_user.nil? && current_user.is_professor?
      @course = Course.find(params[:id])
      @users =   @course.users
    else
      redirect_to root_url
    end
  end

  def edit
    #Check access rights
    if !current_user.nil? && current_user.is_dean?
      @course = Course.find(params[:id])
      #Get all users with professor rank
      @professors = User.where('rank = ?', User::RANK_PROFESSOR)
    else
      redirect_to root_url
    end
  end

  def new
    #Check access rights
    if !current_user.nil? && current_user.is_dean?
      @course = Course.new
      #Get all users with professor rank
      @professors = User.where('rank = ?', User::RANK_PROFESSOR)
      #Set the start year by default to the current year (school year starts 01.08)
      @course.start_year = Course.get_current_year
    else
      redirect_to root_url
    end
  end

  def create
    #Check access rights
    if !current_user.nil? && current_user.is_dean?
      @course = Course.new(params[:course].permit(:name, :start_year, :professor_id))
      if @course.save
        redirect_to action: 'index'
      else
        @course.errors.each do |attribute, error|
          flash.now[:error] = Course.human_attribute_name(attribute) + ' ' +  error.to_s
        end
        @course.errors.clear
        #if error render new page again
        @professors = User.where('rank = ?', User::RANK_PROFESSOR)
        render 'new'
      end
    else
      redirect_to root_url
    end
  end

  def update
    #Check access rights
    if !current_user.nil? && current_user.is_dean?
      @course = Course.find(params[:id])

      if @course.update(params[:course].permit(:name, :start_year, :professor_id))
        redirect_to action: 'index'
      else
        @course.errors.each do |attribute, error|
          flash.now[:error] = Course.human_attribute_name(attribute) + ' ' +  error.to_s
        end
        @course.errors.clear
        @professors = User.where('rank = ?', User::RANK_PROFESSOR)
        render 'edit'
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    if !current_user.nil? && current_user.is_dean?
      @course = Course.find(params[:id])
      if @course.destroy
        redirect_to action: 'index'
      else
        redirect_to @course, :flash => { :error => 'Failed to delete course' }
      end
    else
      redirect_to root_url
    end

  end

  # initalisze required variables for add action
  # Sets min_year, max_year and curr_year (for year dropdown list)
  # Gets the courses for the current year
  def couses_add_view_init
    @curr_year = params[:year]
    if params[:year].nil?
      @curr_year = Course.get_current_year
    else
      @curr_year =params[:year].to_i
    end

    @min_year = Course.minimum('start_year')
    if  @min_year.nil?
      @min_year = Course.get_current_year
    else
      @min_year = @min_year.to_i
    end
    @min_year = Course.get_current_year if @min_year > Course.get_current_year


    @max_year = Course.maximum('start_year')
    if  @max_year.nil?
      @max_year = Course.get_current_year
    else
      @max_year = @max_year.to_i
    end
    @max_year = Course.get_current_year if @max_year < Course.get_current_year
    @courses = Course.where(start_year: @curr_year)
  end

  # Removes a students from a course
  def destroy_user_from_course
    if !current_user.nil? && current_user.is_professor?
      @course = Course.find(params[:id])

      @user = User.find(params[:user])
      @course.users.delete(@user)
      redirect_to course_path(@course)
    else
      redirect_to root_url
    end
  end

  # View for adding a student to a course
  def new_user_to_course

    if !current_user.nil? && current_user.is_professor?
      @course = Course.find(params[:id])
      @students = User.where('rank = ? ',User::RANK_STUDENT)
      @students -= @course.users
      render 'new_user_to_course'
    else
      redirect_to root_url
    end
  end

  # Add a student to a course
  def create_user_for_course
    if !current_user.nil? && current_user.is_professor?

      @course = Course.find(params[:id])
      if params[:course].nil?
        flash.now[:error] = 'No Student selected'
        redirect_to course_path(@course)
      else

        @user = User.find(params[:course]['last_user_id'])
        if @course.users.append(@user)
          redirect_to course_path(@course)
        else
          render 'new'
        end
      end
    else
      redirect_to root_url
    end
  end
end
