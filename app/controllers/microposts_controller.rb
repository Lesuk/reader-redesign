class MicropostsController < ApplicationController
	before_action :signed_in_user, only: [:show, :create, :destroy]
	#before_action :correct_user, only: :destroy
	skip_before_action :verify_authenticity_token

	def show
		@micropost = Micropost.find(params[:id])
		@commentable = @micropost
		@comments = @commentable.comments
		@comments_count = @micropost.comments.count
	end

	def create
		@micropost = current_user.microposts.build(micropost_params)
		@user = current_user
		if @micropost.save
			respond_to do |format|
				format.html { 
					redirect_to root_url 
					flash[:success] = "Micropost created!" 
				}
				format.js
			end
		else
			respond_to do |format|
			format.html { 
				@feed_items = [] 
				render 'static_pages/home' 
			}
			format.js { render 'fail_create.js.erb' }
			end
		end
	end

	def destroy
		@micropost = Micropost.find_by(id: params[:id])
		@user = current_user
		@micropost.destroy
		respond_to do |format|
			format.html { redirect_to root_url }
			format.js
		end
	end

	def repost
		@tweet = Micropost.find(params[:id])
		if !current_user?(@tweet.user) 
			notice = @tweet.retweet_by(current_user)
			@reposts = @tweet.repost_count(@tweet.id).to_i 
			respond_to do |format|
				format.html{
					flash[:notice] = notice
					redirect_to root_url
				}
				format.js
			end
		else
			redirect_to :back, notice: "You can't do repost your message!"
		end
	end

	def like
		@micropost = Micropost.find(params[:id])
		@liked = current_user.liked_for?(@micropost)
		if @liked
		  like_reset
		  @likes = @micropost.reputation_for(:mpost_likes).to_i
		  respond_to do |format|
		  	format.html{ redirect_to :back, notice: "Like reset!" }
			format.js
		  end
		else
		  @micropost.add_evaluation(:mpost_likes, 1, current_user)
		  @likes = @micropost.reputation_for(:mpost_likes).to_i
		  respond_to do |format|
		  	format.html{ redirect_to :back, notice: "Thank you for like :)" }
			format.js
		  end
		end
	end

	def like_reset
		@micropost.delete_evaluation(:mpost_likes, current_user)
	end

	def favorite
		@micropost = Micropost.find(params[:id])
		@favorite_present = @micropost.fans.where(id: current_user).present?
		if @favorite_present
			current_user.favorite_mposts.delete(@micropost)
			@favorites_size = @micropost.fans.size
			respond_to do |format|
				format.html{
					redirect_to :back, notice: 'You unfavorited micropost'
				}
				format.js
			end
		else
			current_user.favorite_mposts << @micropost
			@favorites_size = @micropost.fans.size
			respond_to do |format|
				format.html{
					redirect_to :back, notice: 'Micropost marked as favorite'
				}
				format.js
			end
		end
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