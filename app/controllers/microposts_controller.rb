class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	#before_action :correct_user, only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			#respond_to do |format|
				#format.html { 
			redirect_to root_url 
			flash[:success] = "Micropost created!" 
				#}
				#format.js
			#end
		else
			#respond_to do |format|
				#format.html { 
			@feed_items = [] 
			render 'static_pages/home' 
				#}
				#format.js { render 'fail_create.js.erb' }
			#end
		end
	end

	def destroy
		@micropost = Micropost.find_by(id: params[:id])
		@micropost.destroy
		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
	end

	def retweet
		tweet = Micropost.find(params[:id])
		flash[:notice] = tweet.retweet_by(current_user)
		redirect_to root_url
	end

	def like
		@micropost = Micropost.find(params[:id])
		if current_user.liked_for?(@micropost)
		  like_reset
		  redirect_to :back, notice: "Like reset!"
		else
		  @micropost.add_evaluation(:mpost_likes, 1, current_user)
		  redirect_to :back, notice: "Thank you for like :)"
		end
	end

	def like_reset
		@micropost.delete_evaluation(:mpost_likes, current_user)
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :mpost_picrute)
		end

		#def correct_user
			#@micropost = current_user.microposts.find_by(id: params[:id])
			#redirect_to root_url if @micropost.nil?
		#end

end