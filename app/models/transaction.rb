class Transaction < ActiveRecord::Base
  #Las tarjetas podrían pertenecer a varios Usuarios --> Tarjetas familiares
  belongs_to :user
  belongs_to :card
  belongs_to :business
  belongs_to :era

  attr_accessible :points_aft, :points_bef, :points_type, :total
end
