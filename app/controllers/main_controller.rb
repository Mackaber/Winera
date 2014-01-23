class MainController < ApplicationController

  def landing
    if current_user
      redirect_to main_index_path
    else
      redirect_to "http://get.winero.mx"
    end
  end


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
    end
  end


  def account
    @user = current_user
    @eras = @user.eras

    if Card.find_by_code(session[:new_card])
      @card_code = Card.find_by_code(session[:new_card]).code
      session[:new_card] = ""
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

end
