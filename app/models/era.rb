class Era < ActiveRecord::Base
  belongs_to :business
  belongs_to :card
  # :through Association
  belongs_to :user
  attr_accessible :era_points
end
