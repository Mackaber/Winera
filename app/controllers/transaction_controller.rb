class TransactionController < ApplicationController

  #GET Evaluate
  def index
    @transaction = Transaction.new
  end

  #POST Validate
  def use_era_points
    #TODO: Luego cambiar esto por algo más elegante y apropiado
    @transaction = Transaction.new

    @total = params[:total].to_i
    #El user de la transacción es el que administrador del negocio
    @transaction.user = current_user
    @transaction.total = @total
    #CHECAR
    @card = Card.find_by_code(params[:card_id])
    @transaction.card = @card
    @user = @card.user
    #TODO: Cambiar
    @business = Business.find(session[:current_business])
    @transaction.business = @business
    @transaction.points_type = "era"
    #Busca la era (relación usuario negocio) para abonarle puntos
    @era = @card.eras.find_by_business_id(@business)
    @transaction.points_bef = @era.era_points
    @percentage = @business.percentage
    #TODO: Preguntar sobre la operación Real
    respond_to do |format|
      User.transaction do
        begin
          if @era.era_points >= @total
            @era.update_attribute(:era_points,@era.era_points - @total)
          elsif @era.era_points < @total
            @era.update_attribute(:era_points,@total*@percentage)
          end
        rescue ActiveRecord::RecordInvalid
          format.html { redirect_to "/businesses" }
          #format.xml {render xml: 'pages/home'}
          raise ActiveRecord::Rollback
        end
      end

      @transaction.points_aft = @era.era_points

      if @transaction.save
        #TODO: Mandarlo a los detalles del cliente
        format.html { redirect_to "/businesses/" + session[:current_business].to_s }
        #format.json { head :no_content }
      else
        format.html { redirect_to "/main/account", notice: 'No tienes suficiente Saldo' }
        #format.json { render json: @startup.errors, status: :unprocessable_entity }
      end

    end
  end
end
