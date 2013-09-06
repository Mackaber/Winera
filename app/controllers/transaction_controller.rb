class TransactionController < ApplicationController
  #POST Validate
  def use_era_points
    @code = session[:card_code]
    @total = session[:total]

    @card = Card.find_by_code(@code)

    @business = current_user.businesses.first

    @era = @card.eras.find_by_business_id(@business.id)
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

    @transaction = Transaction.new
    @transaction.business = @business
    @transaction.card = @card
    @transaction.user = @card.user
    @transaction.points_bef = @d_inicio
    @transaction.total = @total

    respond_to do |format|
      Era.transaction do
        begin
          @era.update_attribute(:era_points,@final)
        rescue ActiveRecord::RecordInvalid
          format.html { redirect_to "/card", notice: 'Ocurrio un Error' }
          #format.xml {render xml: 'pages/home'}
          raise ActiveRecord::Rollback
        end
      end

      @transaction.points_aft = @era.era_points

      if @transaction.save
        format.html { redirect_to "/card", notice: "Transaccion finalizada Satisfactoriamente" }
        #format.json { head :no_content }
      else
        format.html { redirect_to "/card", notice: 'Ocurrio un Error' }
        #format.json { render json: @startup.errors, status: :unprocessable_entity }
      end

    end
  end
end
