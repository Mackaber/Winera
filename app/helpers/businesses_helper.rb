module BusinessesHelper
  # Returns if the transactions was and adding or a use of the points
  def points_added(t)
    if t.points_bef < t.points_aft
      t.points_aft - t.points_bef
    elsif t.prepaid?
      t.points_aft
    else
      t.points_bef - t.points_aft
    end
  end

  # Returns The Action
  def points_action(t)
    if t.points_bef < t.points_aft
      "Abonados"
    elsif t.prepaid?
      "Prepagados"
    else
      "Usados"
    end
  end

end
