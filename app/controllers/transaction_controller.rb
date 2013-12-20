class TransactionController < ApplicationController
  #POST Validate
  def use_era_points

    # Se añade .where("prepaid != true") para verificar que las visitas no fueron por precargas

    @function = session[:function]
    @code = session[:card_code]
    @total = session[:total]

    @card = Card.find_by_code(@code)

    @business = current_user.businesses.first

    @era = @card.eras.find_by_business_id(@business.id)

    # Percentage According to the level
    @percentage = @business.lvl_prc(@era.level)

    @d_inicio = @era.era_points                    #Dinero Electrónico al inicio

    @prepaid = false

    if  @function == "Usar Puntos"
      if @total >= @d_inicio
        @d_usado  =  @d_inicio                       #Dinero Electrónico usado
        @restante =  @total - @d_usado               #Restante por pagar
      elsif @total < @d_inicio
        @d_usado  =  @total                          #Dinero Electrónico usado
        @restante = @d_usado - @total                #Restante por pagar
      end
    elsif @function == "Abonar Puntos"
      @d_usado = 0
      @restante = @total
    elsif @function == "Precargar Tarjeta"
      @d_usado = 0
      @restante = 0
      @prepaid = true
      @d_inicio = @total
    else
      format.html { redirect_to "/card", notice: 'Ocurrio un Error' }
    end

    @generado = @restante*@percentage               #Dinero Electrónico generado
    @final    = @generado + (@d_inicio - @d_usado)  #Dinero Electrónico al final

    # The last transaction before the new is added, for comparison
    @last_transaction = @era.transactions.where("prepaid != true").last

    @transaction = Transaction.new
    @transaction.business = @business
    @transaction.card = @card
    @transaction.user = @card.user
    @transaction.era = @era
    @transaction.points_bef = @d_inicio
    @transaction.total = @total
    @transaction.prepaid = @prepaid

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

        # Check for events
        # Solo Eventos al día
        unless @prepaid
          if @last_transaction.created_at.day != @era.transactions.where("prepaid != true").last.created_at.day

          # Add Exp for the visit
          @era.add_exp(5)
          #Pendiente!
          #@transaction.add_event(Event.find_by_description(""))

          # First Visit
          if @era.transactions.where("prepaid != true").count < 2
            @era.add_exp(5)
          end

          # More than 1 visit in the month
          if @last_transaction
            if @last_transaction.created_at.month == @era.transactions.where("prepaid != true").last.created_at.month
              @era.add_exp(5)
            end
          end

          # More than the Business Goal
          if @total > @business.goal
            @era.add_exp(10)
          end
        end
        end
        #format.json { head :no_content }
      else
        format.html { redirect_to "/card", notice: 'Ocurrio un Error' }
        #format.json { render json: @startup.errors, status: :unprocessable_entity }
      end

    end
  end
end
