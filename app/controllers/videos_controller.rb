class VideosController < ApplicationController

	def index
		@videos = Video.paginate(per_page: 20, page: params[:page])
	end

	def new
		@video = Video.new
	end

	def create
		@video = current_user.videos.new(video_params)
		if @video.save
			flash[:success] = 'Video added!'
			redirect_to videos_url
		else
			render 'new'
		end
	end

	def destroy
		@video = current_user.videos.find(params[:id])
		@video.destroy
		respond_to do |format|
			format.html { redirect_to videos_url, flash[:success] = "Video deleted" }
			format.js
		end
	end

private

	def video_params
		params.require(:video).permit(:link)
	end

end
