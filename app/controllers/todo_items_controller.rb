class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create, :new]

	def new
		@todo_item = @todo_list.todo_items.new
	end

	def deadline
		puts @todo_item.inspect
		@todo_item.update(todo_item_params)
		if @todo_item[:deadline] < Time.now
			complete
		else
			redirect_to user_todo_lists_path(current_user)
		end
		#redirect_to user_todo_lists_path(current_user), notice: "Deadline is added"
	end

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)

		respond_to do |format|
			format.html { redirect_to user_todo_lists_url }
			format.js
		end
	end

	def move_up
  	@todo_item.move_higher
  	redirect_to user_todo_lists_path(current_user)
	end

	def move_down
  	@todo_item.move_lower
  	redirect_to user_todo_lists_path(current_user)
	end

	def destroy
		if @todo_item.destroy
			respond_to do |format|
				format.js
				format.html { redirect_to user_todo_lists_url }
			end
			flash[:succes] = "Todo List item was deleted"
		else
			flash[:error] = "Todo List item could not be deleted"
		end
	end

	def edit
  end

  def update
    if @todo_item.update(todo_item_params)
    	if @todo_item[:deadline] < Time.now
				complete
			else
    		redirect_to user_todo_lists_path(current_user)
    	end
    end
 
  end

	def complete
		@todo_item.update_attribute(:completed_at, Time.now)
		redirect_to user_todo_lists_path(current_user), notice: "Todo item completed"
	end

	private

	def set_todo_list
		@todo_list = TodoList.find(params[:todo_list_id])
	end

	def set_todo_item
		@todo_item = @todo_list.todo_items.find(params[:id])
	end

	def todo_item_params
		params.require(:todo_item).permit(:deadline, :content)
	end
end
