class MainController < ApplicationController

  #def landing
  #  if current_user
  #    redirect_to main_index_path
  #  else
  #    redirect_to "http://get.winero.mx"
  #  end
  #end

  def index
    #Redirecciona en caso de que haya un usuario con o sin negocios
    if current_user
      if current_user.business_owner?
        respond_to do |format|
          format.html  { redirect_to "/card" }
          #format.json { render json: @empresas }
        end
      elsif current_user.role == "GOD"
        respond_to do |format|
          format.html  { redirect_to "/businesses" }
          #format.json { render json: @empresas }
        end
      else
        respond_to do |format|
          format.html  { redirect_to "/main/account" }
          #format.json { render json: @empresas }
        end
      end
    else
      redirect_to "/landing.html"
    end
  end

  def login
  end


  def account
    @user = current_user
    @eras = @user.eras

    if Card.find_by_code(session[:new_card])
      @card_code = Card.find_by_code(session[:new_card]).code
      session[:new_card] = ""
    end
    respond_to do |format|
      format.html # login.html.erb
    end
  end

end
