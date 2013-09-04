class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end
  #helper_method :current_user

  def after_sign_in_path_for(resource)
    #Dejar que ese controlador haga la redirección
    '/main/index'
  end

  def set_current_business(biz)
    @current_business = biz
  end

  def current_business
    @current_business
  end

  helper_method :current_business

end
