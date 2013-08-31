class Era < ActiveRecord::Base
  belongs_to :business
  belongs_to :card
  attr_accessible :era_points
end
