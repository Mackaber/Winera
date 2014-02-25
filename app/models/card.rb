class Card < ActiveRecord::Base
  belongs_to :user
  has_many :eras
  attr_accessible :code

  validates_uniqueness_of :code #, :scope => :user
  validates_uniqueness_of :user_id , :scope => :code

  #V---------------------------------------Points Methods------------------------------------------V

  # Add the points to the user user.add_points(points,business)
  def add_points(points,business)
    @era = self.eras.find_by_business_id(business)
    if @era
      @era.update_attribute(:era_points,@era.era_points + points)
    else
      @era = Era.new
      @era.business = business
      @era.user = self
      @era.era_points = points
      @era.save
    end
  end

  # Add the points to the user user.remove_points(business)
  def remove_points(business)
    @era = self.eras.find_by_business_id(business)
    if @era && (@era.era_points - points > 0)
      @era.update_attribute(:era_points,@era.era_points - points)
    else
      false
    end
  end

end
