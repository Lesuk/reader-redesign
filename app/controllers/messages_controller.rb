class MessagesController < ApplicationController
	before_action :set_message, only: [:show, :destroy]
	before_action :signed_in_user, only: [:index, :show, :sent, :new, :create, :destroy]

	def index
		@user = current_user
		@messages = Message.where(recepient_id: @user.id).paginate(page: params[:page], per_page: 20)
	end

	def sent
		@user = current_user
		@messages = Message.where(sender_id: @user.id).paginate(page: params[:page], per_page: 20)
		render 'sent'
	end

	def show
		@user = current_user
		@sender = User.find_by(id: @message.sender_id)
		@recipient = User.find_by(id: @message.recepient_id)
		if ((@user.id == @message.sender_id) || (@user.id == @message.recepient_id ))
		else
			respond_to do |format|
				format.html { redirect_to action: :index, notice: "No message found" }
				format.json { render json: @message.errors, status: :unprocessable_entity }
			end
		end
	end

	def new
		@message = Message.new
		@recepients = [] 
		@user = current_user
		@users = @user.followers
		@users.each do |i|
			u = [i.name, i.id]
			@recepients.push(u)
		end
	end

	def create
		@message = Message.new(message_params)
		@message.sender_id = current_user.id
		if @message.save
			flash[:success] = "Message has been sent"
			redirect_to @message
		else
			render 'new'
		end
	end

	def destroy
		@message.destroy
		flash[:success] = "Message deleted"
		redirect_to sent_messages_path
	end

private
	def message_params
		params.require(:message).permit(:sender_id, :recepient_id, :subject, :body, :read)
	end

	def set_message
		@message = Message.find(params[:id])
	end
end
