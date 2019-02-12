class TodoItemsController < ApplicationController

	before_action :set_todo_list, except: :complete
	before_action :set_todo_item, except: [:create, :new, :complete]

	def new
		@todo_item = @todo_list.todo_items.new
	end

	def create
		@todo_item = @todo_list.todo_items.create(todo_item_params)
		redirect_to user_todo_list_path(current_user, @todo_list)
	end

	def destroy
		if @todo_item.destroy
			flash[:succes] = "Todo List item was deleted"
		else
			flash[:error] = "Todo List item could not be deleted"
		end
		redirect_to user_todo_list_path(current_user, @todo_list)
	end

	def edit
  end

  def update
    if @todo_item.update(todo_item_params)
    	redirect_to user_todo_list_path(current_user, @todo_list)
    end
  end

	def complete
		@todo_list = TodoList.find(params[:id])
		@todo_item = @todo_list.todo_items.find(params[:todo_list_id])
		@todo_item.update_attribute(:completed_at, Time.now)
		redirect_to  user_todo_list_path(current_user, @todo_list), notice: "Todo item completed"
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
