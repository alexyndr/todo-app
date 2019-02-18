class TodoItemsController < ApplicationController
	before_action :set_todo_list
	before_action :set_todo_item, except: [:create, :new]

	def new
		@todo_item = @todo_list.todo_items.new
	end

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to user_todo_lists_path(current_user)
	end

	def destroy
		if @todo_item.destroy
			flash[:succes] = "Todo List item was deleted"
		else
			flash[:error] = "Todo List item could not be deleted"
		end
		redirect_to user_todo_lists_path(current_user)
	end

	def edit
  end

  def update
    if @todo_item.update(todo_item_params)
    	redirect_to user_todo_lists_path(current_user)
    end
  end

	def complete
		@todo_list = TodoList.find(params[:todo_list_id])
		@todo_item = @todo_list.todo_items.find(params[:id])
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
		params[:todo_item].permit(:content)
	end

end
