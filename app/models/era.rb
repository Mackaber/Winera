class Era < ActiveRecord::Base
  belongs_to :business
  belongs_to :card
  # :through Association
  belongs_to :user
  has_many :transactions
  attr_accessible :era_points,:exp,:level

  def add_exp(exp)
    self.update_attribute(:exp, self.exp += exp)

    # Level Growing
    if self.exp > 14 && self.level == 1
      self.levelup!
    elsif self.exp > 29 && self.level == 2
      self.levelup!
    elsif self.exp > 59 && self.level == 3
      self.levelup!
    elsif self.exp > 119 && self.level == 4
      self.levelup!
    end
  end

  def levelup!
    self.update_attribute(:level,self.level += 1)
    # TODO: Send Notifications
  end
end
