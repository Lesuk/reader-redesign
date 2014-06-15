module MicropostsHelper
	def embed(youtube_id)
	    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}?feature=oembed", frameborder: "0")
  	end
end
