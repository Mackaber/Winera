module CardsHelper

  def def_format(s)
    #Cuando se escribe sin guiones
    if s.length == 16
      return s[0..3] + "-" + s[4..7] + "-" +  s[8..11] + "-" + s[12..15]
    elsif s.include? " "
      return s.gsub(" ","-")
    else
      return s
    end
  end

end
