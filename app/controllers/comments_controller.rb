class CommentsController < ApplicationController
	before_action :load_commentable

	def new
		@comment = @commentable.comments.new
	end

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			respond_to do |format|
				format.html { redirect_to @commentable, flash[:success] = "Comment added" }
				format.js
			end
		else
			respond_to do |format|
				format.html {redirect_to @commentable}
				format.js {render 'fail_create.js.erb'}
			end
		end
	end

	def destroy
		#@article = current_user.articles.friendly.find(params[:article_id])
		@comment = @commentable.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @commentable, flash[:success] = "Comment deleted" }
			format.js
		end
	end


	private

		def load_commentable
			#@article = Article.friendly.find(params[:article_id])
			klass = [Article, Micropost].detect {|c| params["#{c.name.underscore}_id"] }
			if klass.name.underscore == "article"
				@commentable = klass.friendly.find(params["#{klass.name.underscore}_id"])
			else
				@commentable = klass.find(params["#{klass.name.underscore}_id"])
			end
		end

		def comment_params
			params.require(:comment).permit(:body)
		end

end