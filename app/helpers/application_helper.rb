module ApplicationHelper

  def background
    if @page == 'main'
      "/assets/fondo1.jpg"
    end
  end

  def level_progress(lvl)
    case lvl
      when 1; 15.0;
      when 2; 30.0;
      when 3; 60.0;
      when 4;120.0;
      else
    end
  end

end
