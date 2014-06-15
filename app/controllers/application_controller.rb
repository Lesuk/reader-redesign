class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :micro_post, :count_mess

  private

  	def micro_post
  		if signed_in? && current_user
  			@micropost = current_user.microposts.build
  		end
  	end

    def count_mess
      @count_mess = Message.where(recepient_id: current_user, read: 0).count
    end
  
end
