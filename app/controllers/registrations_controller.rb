class RegistrationsController < Devise::RegistrationsController
  def new
    @referer = User.find(params[:ref_id])
    #@randnum = User.randnum
    #if User.find_by_nouser(@User.notarjeta)
    super
  end

  def create

  end

  def update
    super
  end

end
