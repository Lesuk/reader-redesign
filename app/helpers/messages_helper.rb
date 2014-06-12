module MessagesHelper

	def marked_as_read(message)
		if @message.read != true
		  @message.read = true
		  @message.save 
		end
	end

end
