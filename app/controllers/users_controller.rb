class UsersController < ApplicationController

	before_action :signed_in_user, 	only: [:index, :edit, :update, :destroy, :following, :followers]
	before_action :correct_user,	only: [:edit, :update]
	before_action :admin_user,     only: :destroy

	def index
		#@users = User.paginate(page: params[:page])
		@users = User.search(params[:search]).paginate(per_page: 8, page: params[:page])
	end

	def show
		#@user = User.find(params[:id])
		@user = User.find_by_login(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
		@title = @user.name
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)	
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Reader!"
			#UserMailer.signup_confirmation(@user).deliver
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find_by_login(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	def following
		@title = "Following"
		@user = User.find_by_login(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find_by_login(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	private

		def user_params
			params.require(:user).permit(:name, :login, :email, :password, :password_confirmation, :avatar, :remove_avatar)
		end

		def correct_user
	      @user = User.find_by_login(params[:id])
	      redirect_to(root_url) unless current_user?(@user)
	    end

	    def admin_user
      		redirect_to(root_url) unless current_user.admin?
    	end
end