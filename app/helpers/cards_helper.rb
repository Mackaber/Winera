module CardsHelper

  def def_format(s)
    if s.length == 19
      return s[0..3] + "-" + s[4..7] + "-" +  s[8..11] + "-" + s[12..15]
    elsif s.include? " "
      return s.gsub(" ","-")
    else
      return s
    end
  end

end
