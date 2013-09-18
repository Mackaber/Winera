class MainController < ApplicationController
  def index

#Redirecciona en caso de que haya un usuario con o sin negocios
    if current_user

      if current_user.businesses.any?
        respond_to do |format|
          format.html  { redirect_to "/card" }
          #format.json { render json: @empresas }
        end
      else
        respond_to do |format|
          format.html  { redirect_to "/main/account" }
          #format.json { render json: @empresas }
        end
      end

    else
      respond_to do |format|
        format.html # index.html.erb
      end
    end
  end


  def account
    @user = current_user
    @eras = @user.eras

    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
