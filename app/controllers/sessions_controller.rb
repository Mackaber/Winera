class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    #raise request.env["omniauth.auth"].to_yaml
    redirect_to edit_user_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end

end