class TasksController < ApplicationController
	before_action :signed_in_user, only: [:index, :create, :update, :destroy]
	before_action :set_task, only: [:update, :destroy]

	def index
		@tasks = current_user.tasks.in_process.priority_order
		@tasks_done = current_user.tasks.done
		@task = Task.new
	end

	def create
		@task = current_user.tasks.new(task_params)
		if @task.save
			respond_to do |format|
				format.html { redirect_to tasks_url }
				format.js
			end
		else
			respond_to do |format|
				format.html { redirect_to tasks_url }
				format.js {render 'fail_create.js.erb'}
			end
		end
	end

	def update
		if @task.update_attributes(task_params)
			respond_to do |format|
		      format.html { redirect_to tasks_url }
		      format.js
		    end
		else
			respond_to do |format|
		      format.html { head :no_content }
		      format.js
		    end
		end
	end

	def destroy
		@task.destroy
		respond_to do |format|
			format.html { redirect_to tasks_url, flash[:success] = "Task deleted" }
			format.js
		end
	end

private

	def set_task
		@task = current_user.tasks.find(params[:id])
	end
	
	def task_params
		params.require(:task).permit(:title, :note, :completed, :priority, :due_date)
	end


end
