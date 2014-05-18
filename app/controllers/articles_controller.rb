class ArticlesController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :edit, :update, :destroy]
	before_action :set_article, only: [:show, :vote]

	def index
		@name = ""
		if params[:category]
			@articles = Article.includes(:comments).categorized_with(params[:category])
		elsif params[:author]
			#@articles = Article.users_articles(params[:author])
			@articles = Article.includes(:comments).by_author(params[:author])
			@name = "by " + User.find_by_id(params[:author]).name
		else			
			@articles = Article.includes(:comments).search(params)
		end
	end

	def show
		@commentable = @article
		@comments = @commentable.comments
		
		view = Postview.new(article_id: @article.id, guest_ip: request.remote_ip)
		view.save!
		@postViews = @article.postviews.count
		@postUniqueViews = @article.postviews.uniq_by {|i| i.guest_ip }.count
	end

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new(article_params)
		if @article.save
			flash[:success] = "New article has been created."
			micro_post_title = view_context.link_to(@article.title, @article)
			#micropost = current_user.microposts.build(content: micro_post_content)
			micropost = current_user.microposts.build(content: @article.title, 
				mtitle: micro_post_title, mpost_picrute: @article.thumbnail)

			micropost.save
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		@article = current_user.articles.friendly.find(params[:id])
	end

	def update
		@article = current_user.articles.friendly.find(params[:id])
		if @article.update_attributes(article_params)
			redirect_to @article
			flash[:success] = "Article updated"
		else
			render 'edit'
		end
	end

	def destroy
		@article = current_user.articles.friendly.find(params[:id])
		@article.destroy
		flash[:success] = "Article deleted"
		redirect_to articles_url
	end

	def vote
		thumbs = params[:type]
		if current_user.voted_for?(@article, thumbs)
		  vote_reset
		  redirect_to :back, notice: "Vote reset!"
		else
		  value = params[:type] == "up" ? 1 : -1
		  @article.add_or_update_evaluation(:votes, value, current_user)
		  redirect_to :back, notice: "Thank you for voting"
		end
	end 

	def vote_reset
		@article.delete_evaluation(:votes, current_user)
	end

	private

		def set_article
			@article = Article.friendly.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:title, :content, :publish_date, :category_list, :thumbnail)
		end

end