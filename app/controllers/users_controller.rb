class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_dean , :except => [:edit_user_options, :update_user_options]

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def edit_user_options
    @user = current_user
  end

  def update_user_options
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to root_path
    else
      render "edit_user_options"
    end

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

  def user_params
    params[:user].permit(:name, :email, :password, :password_confirmation)
  end

  def check_dean
    unless current_user.isDean?
      redirect_to home_index_path
    end
  end
end