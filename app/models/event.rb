class Event < ActiveRecord::Base
  has_many :summaries

  attr_accessible :condition, :description, :exp_gain
end
