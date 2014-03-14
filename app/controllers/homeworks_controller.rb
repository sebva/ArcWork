class HomeworksController < ApplicationController
  def index
    @homework = Homework.all
  end

  def show
    @homework = Homework.find(params[:id])
  end

  def new
    @homework = Homework.new
  end

  def edit
    @homework = Homework.find(params[:id])
  end

  def create
    @homework = Homework.new(get_params)
    if @homework.save
      redirect_to @homework
    else
      render 'new'
    end
  end

  def update
    @homework = Homework.find(params[:id])
    if @homework.update(get_params)
      redirect_to @homework
    else
      render 'edit'
    end
  end

  def destroy
    @homework = Homework.find(params[:id])
    @homework.destroy
    redirect_to homeworks_path
  end

end
