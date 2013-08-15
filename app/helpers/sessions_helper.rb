module SessionsHelper

  def current_user
    @current_user ||= User.find_by_token(session[:token])
  end

  def must_login
    # puts "CURRENT USER IS: "
 #    p current_user
 #    puts "SESSION TOKEN IS: "
 #    p session[:token]
    redirect_to new_session_url unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def login_user(user)
    session[:token] = user.token
  end

end
