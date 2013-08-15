class SessionsController < ApplicationController

  skip_before_filter :must_login, :only => [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_name(params[:user][:name])
    if user.password_equals?(params[:user][:password])
      session[:token] = user.token
      redirect_to user_url(user)
    else
      flash[:notices] ||= []
      flash[:notices] << "Login failed"
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.change_token!
    session[:token] = nil
    redirect_to new_session_url
  end
end
