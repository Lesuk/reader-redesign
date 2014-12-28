class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :micro_post, :count_mess
  #after_action :flash_to_headers

  private

  	def micro_post
  		if signed_in? && current_user
  			@micropost = current_user.microposts.build
  		end
  	end

    def count_mess
      @count_mess = Message.where(recepient_id: current_user, read: 0).count
    end

    def flash_to_headers
      return unless request.xhr?
      response.headers['X-Message'] = flash_message
      response.headers["X-Message-Type"] = flash_type.flash_to_headers
      flash.discard
    end

    def flash_message
      [:error, :warning, :notice, :success].each do |type|
        return flash[type] unless flash[type].blank?
      end
    end

    def flash_type
      [:error, :warning, :notice, :success].each do |type|
        return type unless flash[type].blank?
      end
    end
  
end
