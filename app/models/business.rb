class Business < ActiveRecord::Base
  belongs_to :user
  has_many :cards
  attr_accessible :category, :description, :image, :lat, :long, :name, :phone, :schedule, :streetadr, :percentage, :goal,
                  :lvl1_prc,:lvl2_prc,:lvl3_prc,:lvl4_prc,:lvl5_prc

  # Returns the Percentage According to the level
  def lvl_prc(lvl)
    case lvl
      when 1; self.lvl1_prc;
      when 2; self.lvl2_prc;
      when 3; self.lvl3_prc;
      when 4; self.lvl4_prc;
      when 5; self.lvl5_prc;
    end
  end
end
