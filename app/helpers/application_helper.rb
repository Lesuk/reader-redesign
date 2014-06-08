module ApplicationHelper

	#Returns the full title on a per-page basis
	def full_title(page_title)
		base_title = "Ruby on Rails App"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def set_icon(name, style)
		if style == "glyph"
    		names =  "glyphicon glyphicon-#{name}"
    	elsif style == "fa"
    		names = "fa fa-#{name}"
    	else
    		names = "#{name}"
    	end
    	content_tag :i, nil, :class => names
  	end

end