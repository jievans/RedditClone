class UsersController < ApplicationController

  skip_before_filter :must_login, :only => [:new, :create]

  def new
    render :new
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def create
    user = User.create!(params[:user])
    login_user(user)
    redirect_to user_url(user)
  end

end
