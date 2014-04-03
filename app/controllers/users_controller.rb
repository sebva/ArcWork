class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_dean

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(get_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  private

  def get_params
    params[:user].permit(:name, :email, :rank)
  end

  def check_dean
    unless current_user.isDean?
      redirect_to home_index_path
    end
  end
end