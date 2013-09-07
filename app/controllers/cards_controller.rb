class CardsController < ApplicationController
  def show
    if params[:card_code]
      if Card.find_by_code(params[:card_code])
        @card_code = Card.find_by_code(params[:card_code]).code
        respond_to do |format|
          format.html # show.html.erb
        end
      else
        respond_to do |format|
          format.html { redirect_to "/card", notice: "No se encontro la Tarjeta" }
        end
      end
    else
      @card_code = ""
      respond_to do |format|
        format.html # show.html.erb
      end
    end
  end

  def confirm
    if Card.find_by_code(params[:card_code])
      @card = Card.find_by_code(params[:card_code])
      @code = @card.code
      @total = params[:total].to_f

      if @card.user
        @user = @card.user.name
      else
        @user = @code
      end

      @visitas =  Transaction.find_all_by_card_id(@card.id).count
      @visitas_mes = Transaction.where("extract(month from created_at) = ? AND card_id = ?", Time.now.month,@card.id).count

      @business = current_user.businesses.first

      #Crear Eras (relaciones Tarjeta Negocio, donde no las hay)
      if @card.eras.find_by_business_id(@business.id)
        @era = @card.eras.find_by_business_id(@business.id)
      else
        Era.transaction do
          begin
           @era = Era.new
           @era.business = @business
           @era.card = @card
           @era.era_points = 0.0
           @era.save
          rescue ActiveRecord::RecordInvalid
            format.html { redirect_to "/card", notice: 'Ocurrio un Error' }
            #format.xml {render xml: 'pages/home'}
            raise ActiveRecord::Rollback
          end
        end
      end

      @percentage = @business.percentage

      @d_inicio = @era.era_points                    #Dinero Electrónico al inicio

      if @total >= @d_inicio
        @d_usado  =  @d_inicio                       #Dinero Electrónico usado
        @restante =  @total - @d_usado               #Restante por pagar
      elsif @total < @d_inicio
        @d_usado  =  @total                          #Dinero Electrónico usado
        @restante = @d_usado - @total                #Restante por pagar
      end
      @generado = @restante*@percentage               #Dinero Electrónico generado
      @final    = @generado + (@d_inicio - @d_usado) #Dinero Electrónico al final

      #TODO: CORREGIR ESTO QUE YA ME FASTIDIO
      #Solucion temporal, usar variables de sesion (ni modo)

      session[:card_code] = @code
      session[:total] = @total

    else
      respond_to do |format|
          format.html { redirect_to "/card", notice: "No se encontro la Tarjeta" }
      end
    end
  end

end
