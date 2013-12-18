class Transaction < ActiveRecord::Base
  #Las tarjetas podrían pertenecer a varios Usuarios --> Tarjetas familiares
  belongs_to :user
  belongs_to :card
  belongs_to :business
  belongs_to :era
  has_many :summaries
  has_many :events, :through => :summaries

  attr_accessible :points_aft, :points_bef, :points_type, :total

  # Add a new Event to the Transaction
  def new_event(event)
    @summary = Summary.new
    @summary.save

    @summary.update_attribute(:event, event)
    @summary.update_attribute(:transaction, self)
  end
end
