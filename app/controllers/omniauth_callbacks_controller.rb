class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      #user.skip_confirmation!
      #raise request.env["omniauth.auth"].to_yaml
      sign_in_and_redirect user, notice: "Usuario Registrado!"
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  
  #def google_oauth2
  #  user = User.from_omniauth(request.env["omniauth.auth"])
  #  if user.persisted?
  #    #El skip es para que no tenga que confirmarse el mail
  #    user.skip_confirmation!
  #    sign_in_and_redirect user, notice: "Usuario Registrado!"
  #  else
  #    session["devise.user_attributes"] = user.attributes
  #    redirect_to new_user_registration_url
  #  end
  #end
  #No se porque, pero esto no jala :(
  #alias_method :facebook, :google_oauth2, :all
end
