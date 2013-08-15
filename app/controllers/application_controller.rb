class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  before_filter :must_login

end
