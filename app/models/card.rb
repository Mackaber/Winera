class Card < ActiveRecord::Base
  belongs_to :user
  has_many :eras
  attr_accessible :code
end
