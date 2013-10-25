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

  #TODO: Por alguna razon esto no funciona como debería...
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, notice: exception.message }
    end
  end

end
