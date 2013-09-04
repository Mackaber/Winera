class CardsController < ApplicationController
  def show
    #TODO: Mandarlo a Error cuando no encuentre la tarjeta
    if params[:card_code]
      @card_code = Card.find_by_code(params[:card_code]).code
    else
      @card_code = ""
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def confirm
    @card = Card.find_by_code(params[:card_code])
    @code = @card.code
    @total = params[:total]
    flash[:card_code] = @code
    flash[:total] = @total
  end

end
