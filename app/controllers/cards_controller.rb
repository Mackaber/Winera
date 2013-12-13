class CardsController < ApplicationController
  include CardsHelper

  #Registra el código de una tarjeta
  def register
    authorize! :register, @card
    if params[:card_code] && Card.find_by_code(def_format(params[:card_code]))
      if !Card.find_by_code(def_format(params[:card_code])).user
        @card = Card.find_by_code(def_format(params[:card_code]))
        @user = current_user
        @card.update_attribute(:user,@user)

        respond_to do |format|
          User.transaction do
            begin
              @user.update_attribute(:newuser,false)
            rescue ActiveRecord::RecordInvalid
              format.html { redirect_to "/main/account", notice: "Ocurrio un error" }
              #format.xml {render xml: 'pages/home'}
              raise ActiveRecord::Rollback
            end
          end

          #En caso de que ya haya comprado con esa tarjeta antes de registrarla a un usuario existente
          @card.eras.each do |e|
            if @user.eras.where("business_id = ?",e.business_id).any?
              @era = @user.eras.where("business_id = ?",e.business_id).first
              Era.transaction do
                begin
                  @era.update_attribute(:era_points,e.era_points + @era.era_points)
                  e.destroy
                rescue ActiveRecord::RecordInvalid
                  format.html { redirect_to "/main/account", notice: "Ocurrio un error" }
                  #format.xml {render xml: 'pages/home'}
                  raise ActiveRecord::Rollback
                end
              end
            end
          end

          format.html { redirect_to "/main/account", notice: "Tarjeta Registrada Satisfactoriamente" }
        end



      else
        respond_to do |format|
          format.html { redirect_to "/main/account", notice: "Tarjeta Ya registrada" }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to "/main/account", notice: "No se encontro la Tarjeta" }
      end
    end

  end

  def show
    authorize! :show, @card
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
    authorize! :confirm, @card
    #Modificar el formato del codigo de ser necesario
    @code = def_format(params[:card_code])
    logger.info(@code)
    if Card.find_by_code(@code)
      @card = Card.find_by_code(@code)
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

      # Percentage According to the level
      @percentage = @business.lvl_prc(@era.level)

      @d_inicio = @era.era_points                    #Dinero Electrónico al inicio
      @function = params[:commit]

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
      else
        format.html { redirect_to "/card", notice: 'Ocurrio un Error' }
      end

      @generado = @restante*@percentage               #Dinero Electrónico generado
      @final    = @generado + (@d_inicio - @d_usado) #Dinero Electrónico al final

      #TODO: CORREGIR ESTO QUE YA ME FASTIDIO
      #Solucion temporal, usar variables de sesion (ni modo)

      session[:card_code] = @code
      session[:total] = @total

      session[:function] = params[:commit]
    else
      respond_to do |format|
          format.html { redirect_to "/card", notice: "No se encontro la Tarjeta" }
      end
    end
  end

end
