class Card < ActiveRecord::Base
  belongs_to :business
  attr_accessible :code, :era_points
end
