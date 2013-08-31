class Business < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  attr_accessible :category, :description, :image, :lat, :long, :name, :phone, :schedule, :streetadr, :percentage
end
