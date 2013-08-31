class CardsController < ApplicationController
  def show
    #TODO: Mandarlo a Error cuando no encuentre la tarjeta
    if params[:card_code]
      @code = Card.find_by_code(params[:card_coded]).code
    else
      @code = ""
    end

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def confirm
    logger.info("----------------")
    logger.info(params[:card_code])
    logger.info("----------------")
    @card = Card.find_by_code(params[:card_code])
    @code = @card.code
  end

end
